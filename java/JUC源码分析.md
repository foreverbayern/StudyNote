[toc]
### ThreadPoolExecutor
线程池源码分析
```java
    // 可以表示线程池状态，线程池中的线程数
    private final AtomicInteger ctl = new AtomicInteger(ctlOf(RUNNING, 0));
    // 29, 一个int是32位,高3位表示线程池状态,低29位表示线程池中线程个数.
    private static final int COUNT_BITS = Integer.SIZE - 3;
    // 高三位为0,低29位为1. 作用是与该参数进行位运算，获取线程池状态
    private static final int CAPACITY   = (1 << COUNT_BITS) - 1;

    // runState is stored in the high-order bits
    //111 代表线程池为RUNNING,正常接受任务
    private static final int RUNNING    = -1 << COUNT_BITS;
    //000 线程池为SHUTDOWN,不接受新任务,但是内部还会处理阻塞队列中的任务,正在进行中的任务也正常处理
    private static final int SHUTDOWN   =  0 << COUNT_BITS;
    //001 不接受新任务,也不处理阻塞队列中的任务,同时会终端正在执行的任务
    private static final int STOP       =  1 << COUNT_BITS;
    //010 过渡的状态,代表当前线程即将完结
    private static final int TIDYING    =  2 << COUNT_BITS;
    //011 要执行terminated(),真的快结束了
    private static final int TERMINATED =  3 << COUNT_BITS;

    // 得到线程池的状态
    private static int runStateOf(int c)     { return c & ~CAPACITY; }
    // 得到当前线程数量
    private static int workerCountOf(int c)  { return c & CAPACITY; }
    private static int ctlOf(int rs, int wc) { return rs | wc; }
```