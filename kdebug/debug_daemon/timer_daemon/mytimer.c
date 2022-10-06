#include <linux/module.h>
#include <linux/timer.h>
#include <linux/jiffies.h>

struct timer_list mytimer;
static u64 tri_cnt = 0;

static void timer_handler(struct timer_list *tl)
{
    tri_cnt ++ ;
    if (++ tri_cnt % 1000 == 0)
	    printk("--%s: jiffies:%lu cpu:%d--\n", 
                __func__, jiffies, smp_processor_id());

	mod_timer(&mytimer,jiffies + 1);
}
static int __init mytimer_init(void)
{
	timer_setup(&mytimer, timer_handler, 0);
	mytimer.function = timer_handler;
    mytimer.expires = jiffies + 1;
	add_timer(&mytimer);   
	return 0;
}
static void __exit mytimer_exit(void)
{
	del_timer(&mytimer);
}
module_init(mytimer_init);
module_exit(mytimer_exit);
 
MODULE_LICENSE("GPL");
MODULE_AUTHOR("wasd003");
