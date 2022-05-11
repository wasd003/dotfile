#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/kprobes.h>

#define MAX_SYMBOL_LEN    64
static char symbol[MAX_SYMBOL_LEN] = "_do_fork";
module_param_string(symbol, symbol, sizeof(symbol), 0644);


static int handle_pre(struct kprobe *p, struct pt_regs *regs)
{
    pr_info("[%pF] ip:%lx, flags:0x%lx", p->addr, regs->ip, regs->flags);

	/* dump_stack(); */
    return 0;
}

static void handle_post(struct kprobe *p, struct pt_regs *regs,
                unsigned long flags)
{
}

/*
 * fault_handler: this is called if an exception is generated for any
 * instruction within the pre- or post-handler, or when Kprobes
 * single-steps the probed instruction.
 */
static int handle_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
{
    pr_info("fault_handler: p->addr = %pF, trap #%d", p->addr, trapnr);
    /* Return 0 because we don't handle the fault. */
    return 0;
}

static struct kprobe kp_do_fork = {
    .symbol_name    = symbol,
	.offset = 0x111,
	.pre_handler = handle_pre,
	.post_handler = handle_post,
	.fault_handler = handle_fault,
};

static int __init kprobe_init(void)
{
    int ret;

    ret = register_kprobe(&kp_do_fork);
    if (ret < 0) {
        pr_err("register_kprobe failed, returned %d\n", ret);
        return ret;
    }
    return 0;
}

static void __exit kprobe_exit(void)
{
    unregister_kprobe(&kp_do_fork);
}

module_init(kprobe_init)
module_exit(kprobe_exit)
MODULE_LICENSE("GPL");
