#include <linux/kernel.h>
#include <linux/module.h>

static int cmd = 0;
static int arg = 0;

module_param(cmd, int, S_IRUGO);
module_param(arg, int, S_IRUGO);

extern bool record_toggle;
extern bool print_toggle;

extern atomic64_t send_msg_cnt;
extern atomic64_t send_msg_tot;

static int __init breakdown_init(void)
{

        pr_info("%s", __func__);
        switch (cmd)
        {
        case 0:
                record_toggle = (arg == 1);
                pr_info("record_toggle set to %s", 
                                record_toggle?"true":"false");
                break;
        case 1:
                print_toggle = (arg == 1);
                pr_info("print_toggle set to %s", 
                                print_toggle?"true":"false");
                break;
        case 2:
                atomic64_set(&send_msg_cnt, 0);
                atomic64_set(&send_msg_tot, 0);
                pr_info("clear all stat data");
                break;
        default:
                pr_err("unexpected cmd:%d", cmd);
        }
        return 0;
}

static void __exit breakdown_exit(void)
{
        pr_info("%s", __func__);
}

module_init(breakdown_init)
module_exit(breakdown_exit)
MODULE_LICENSE("GPL");
