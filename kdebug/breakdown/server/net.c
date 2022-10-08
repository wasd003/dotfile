atomic64_t send_msg_cnt = ATOMIC64_INIT(0);
atomic64_t send_msg_tot = ATOMIC64_INIT(0);

bool record_toggle = false;
EXPORT_SYMBOL(record_toggle);

bool print_toggle = false;
EXPORT_SYMBOL(print_toggle);

#define MAX(a, b) ((a) > (b) ? (a) : (b))

static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
{
        unsigned long a, b;

        b = rdtsc_ordered();
        err = sock->ops->sendmsg(sock, &msg, len);
        a = rdtsc_ordered();

        if (record_toggle) {
                atomic64_add(a - b, &send_msg_tot);
                atomic64_inc(&send_msg_cnt);
        }

        if (print_toggle) {
                unsigned long s_tot = atomic64_read(&send_msg_tot);
                unsigned long s_cnt = atomic64_read(&send_msg_cnt);
                pr_info_ratelimited("[Breakdown] send_msg_tot:%lu send_msg_avg:%lu "
                        s_tot, s_tot / MAX(s_cnt, 1UL));
        }
}
