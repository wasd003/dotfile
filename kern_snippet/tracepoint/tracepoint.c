TRACE_EVENT(dev_queue_xmit,

    TP_PROTO(struct sk_buff *skb),

    TP_ARGS(skb),

    TP_STRUCT__entry(
        __field(void *, skbaddr)
        __field(void *, data)
    ),

    TP_fast_assign(
        __entry->skbaddr = skb;
        __entry->data = skb->data;
    ),

    TP_printk("skb:0x%px skb->data:0x%px", __entry->skbaddr, __entry->data)
);
