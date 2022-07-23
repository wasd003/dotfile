#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/kobject.h>

struct cat {
    int weight;
	char name[20];
    struct kobject kobj;
};
static struct cat *cat;

struct cat_attr {

	/**
	 * cat_attr is a sub class of `struct sttribute`
	 */
    struct attribute attr;

	/**
	 * custom read & write implementation
	 */
    ssize_t (*show)(struct cat *cat, struct cat_attr *attr, char *buf);
    ssize_t (*store)(struct cat *cat, struct cat_attr *attr, const char *buf, size_t count);
};


/**
 * abstract method to show attribute
 * real implementation should be invoked here
 */
static ssize_t abstract_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
{
	/**
	 * retrieve sub class from base class
	 */
	struct cat *cat = container_of(kobj, struct cat, kobj);
    struct cat_attr *cat_attr = container_of(attr, struct cat_attr, attr);
    
    if (cat_attr->show)
        return cat_attr->show(cat, cat_attr, buf);
    
    return -EIO;
}

/**
 * abstract method to store attribute
 * real implementation should be invoked here
 */
static ssize_t abstract_attr_store(struct kobject *kobj, struct attribute *attr, const char *buf, size_t count)
{

	/**
	 * retrieve sub class from base class
	 */
	struct cat *cat = container_of(kobj, struct cat, kobj);
    struct cat_attr *cat_attr = container_of(attr, struct cat_attr, attr);

	if (cat_attr->store)
		return cat_attr->store(cat, cat_attr, buf, count);
	return -EIO;
}

/**
 * abstract read & write method
 */
const struct sysfs_ops cat_general_sysfs_ops = {
    .show = abstract_attr_show,
    .store = abstract_attr_store,
};

void cat_release(struct kobject *kobj)
{
    kfree(kobj);
}

static struct kobj_type cat_type = {
    .release = cat_release,
    .sysfs_ops = &cat_general_sysfs_ops,
};

ssize_t name_show(struct cat *cat, struct cat_attr *attr, char *buffer)
{
    return sprintf(buffer, "%s\n", cat->name);
}

ssize_t weight_show(struct cat *cat, struct cat_attr *attr, char *buffer)
{
    return sprintf(buffer, "%d\n", cat->weight);
}

ssize_t weight_store(struct cat *cat, struct cat_attr *attr, const char *buffer, size_t size)
{
    sscanf(buffer, "%d", &cat->weight);

    return size;
}

struct cat_attr name_attr = __ATTR(name, 0664, name_show, NULL);

struct cat_attr weight_attr = __ATTR(weight, 0664, weight_show, weight_store);

struct attribute *cat_attrs[] = {
    &name_attr.attr,
    &weight_attr.attr,
    NULL,
};

struct attribute_group cat_subdir = {
    .name = "subdir",
	/**
	 * for convenience, just reuse cat_attrs
	 */
    .attrs = cat_attrs,
};

static int __init cat_init(void)
{
    int retval;

    cat = kmalloc(sizeof(struct cat), GFP_KERNEL);
    if (!cat)
        return -ENOMEM;
    
	/**
	 * init cat 
	 */
    memset(&cat->kobj, 0, sizeof(struct kobject));
	cat->weight = 15;
	strcpy(cat->name, "Ketty");

	/**
	 * after this, /sys/cat_dev will be created
	 */
    retval = kobject_init_and_add(&cat->kobj, &cat_type, NULL, "cat_dev");
    if (retval)
		goto free;

	/**
	 * create file
	 */
    retval = sysfs_create_files(&cat->kobj, (const struct attribute **)cat_attrs);
    if (retval)     
		goto free;

	/**
	 * create folder
	 */
    retval = sysfs_create_group(&cat->kobj, &cat_subdir);
    if (retval)
		goto free;

    return 0;

free:
	kobject_put(&cat->kobj);
    return retval;
    
}

static void __exit cat_exit(void)
{
    kobject_del(&cat->kobj);
    kobject_put(&cat->kobj);
    return;
}

module_init(cat_init);
module_exit(cat_exit);

MODULE_AUTHOR("wasd003");
MODULE_LICENSE("GPL");
