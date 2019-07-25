import javax.management.*;
import javax.management.remote.*;
import java.lang.management.*;
import static java.lang.management.ManagementFactory.*;

public class app {
public static void main(String[] args) throws Exception {

    JMXServiceURL address = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://192.168.33.10:12345/jmxrmi");
    JMXConnector connector = JMXConnectorFactory.connect( address );
    MBeanServerConnection mbs = connector.getMBeanServerConnection();

    int Kb = 1024;

    ThreadMXBean threadmxBean = newPlatformMXBeanProxy(mbs, ManagementFactory.THREAD_MXBEAN_NAME, ThreadMXBean.class);
    int threadCount = threadmxBean.getThreadCount();

    MemoryMXBean memBean = ManagementFactory.newPlatformMXBeanProxy(mbs, ManagementFactory.MEMORY_MXBEAN_NAME, MemoryMXBean.class);
    MemoryUsage memHeapUsage = memBean.getHeapMemoryUsage();

    System.out.println("TotalThreads = " + String.valueOf(threadCount) + " Threads");
    System.out.println("heapInit = " + String.valueOf(memHeapUsage.getInit()/Kb) + " Kb");
    System.out.println("heapUsed = " + String.valueOf(memHeapUsage.getUsed()/Kb) + " Kb");
    System.out.println("heapCommited = " +  String.valueOf(memHeapUsage.getCommitted()/Kb) + " Kb");
    System.out.println("heapMax = " +  String.valueOf(memHeapUsage.getMax()/Kb) + " Kb");
  }
}
