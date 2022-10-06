#include <linux/delay.h>

int debug_daemon(void *args)
{
        while (!kthread_should_stop()) {
                /**
                 * daemon operation here
                 */
                msleep(20);
        }
        return 0;
}

kthread_run(debug_daemon, args, "debug_daemon");
