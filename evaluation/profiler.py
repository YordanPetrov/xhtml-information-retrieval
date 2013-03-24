
import subprocess
import time
import matplotlib.pyplot as plt


class MemoryMonitor(object):

    def __init__(self, username):
        """Create new MemoryMonitor instance."""
        self.username = username

    def usage(self):
        """Return int containing memory used by user's processes."""
        self.process = subprocess.Popen("ps -p 3161 -o rss | awk '{sum+=$1} END {print sum}'" % self.username,
                                        shell=True,
                                        stdout=subprocess.PIPE,
                                        )
        self.stdout_list = self.process.communicate()[0].split('\n')
        return int(self.stdout_list[0])

    def measure(self, interval):
        usages = []
    
        for i in range(interval):
            usages.append(self.usage())
            time.sleep(0.2)
        
        plt.plot(usages)
        plt.ylabel('Mem Usage')
        plt.show()