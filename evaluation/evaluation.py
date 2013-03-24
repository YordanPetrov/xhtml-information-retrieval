import time
import os
import subprocess
import shutil
import urllib2
import time
from BeautifulSoup import BeautifulSoup

class Evaluation():
  """Evaluation baby"""
  def __init__(self):
    self.dir = os.getcwd()
    self.ignore = ["cxinfr09039.htm", "cxinfr09040.htm", "cxinfr10037.htm", "cxinfr10038.htm", "cxinfr10042.htm", "cxinfr10044.htm", "cxinfr10049.htm", "cxinfr11011.htm", "cxinfr11017.htm", "cxinfr11021.htm", "cxinfr11022.htm", "cxinfr11023.htm", "cxinfr11024.htm", "cxinfr11027.htm", "cxinfr11030.htm", "cxinfr11031.htm", "cxinfr11032.htm", "cxinfr11034.htm", "cxinfr11038.htm", "cxinfr11042.htm", "cxinfr11043.htm", "cxinfr11044.htm", "cxinfr11048.htm", "cxinfr11049.htm", "cxinfr11053.htm", "cxinfr11054.htm", "cxinfr11055.htm", "cxinfr11058.htm", "cxinfr11060.htm", "cxinfr11062.htm", "cxinfr11063.htm", "cxinfr11064.htm", "cxinfr11067.htm", "cxinfr11071.htm", "cxinfr11074.htm", "cxinfr11076.htm", "cxinfr11077.htm", "cxinfr11082.htm", "cxinfr11084.htm", "cxinfr11086.htm", "cxinfr07002.htm", "cxinfr08006.htm", "cxinfr09012.htm", "cxinfr09026.htm", "cxinfr09033.htm", "cxinfr09037.htm", "cxinfr09038.htm", "cxinfr10003.htm", "cxinfr10020.htm", "cxinfr10021.htm", "cxinfr10026.htm", "cxinfr10027.htm", "cxinfr10028.htm", "cxinfr10029.htm", "cxinfr10030.htm", "cxinfr10031.htm", "cxinfr10035.htm", "cxinfr10036.htm", "cxinfr10040.htm", "cxinfr10043.htm", "cxinfr10045.htm", "cxinfr10047.htm", "cxinfr11009.htm", "cxinfr11015.htm", "cxinfr11018.htm", "cxinfr11019.htm", "cxinfr11025.htm", "cxinfr11026.htm", "cxinfr11039.htm", "cxinfr11040.htm", "cxinfr11041.htm", "cxinfr11047.htm", "cxinfr11051.htm", "cxinfr11052.htm", "cxinfr11056.htm", "cxinfr11057.htm", "cxinfr11061.htm", "cxinfr11066.htm", "cxinfr11068.htm", "cxinfr11069.htm", "cxinfr11070.htm", "cxinfr11072.htm", "cxinfr11075.htm", "cxinfr11079.htm", "cxinfr11080.htm", "cxinfr11081.htm", "cxinfr11083.htm"]
    # self.filenames = os.listdir(self.dir)

  def fetch_all(self):
    self.fetch_pages('http://www.drps.ed.ac.uk/12-13/dpt/cx_sb_math.htm')
    self.fetch_pages('http://www.drps.ed.ac.uk/12-13/dpt/cx_sb_infr.htm')

  def fetch_pages(self, base_url):
    base_url2 = 'http://www.drps.ed.ac.uk/12-13/dpt/'
    r = urllib2.urlopen(base_url).read()
    soup = BeautifulSoup(r)
    all_links = soup.findAll('a')
    links = {}
    for link in all_links:
      if "cx" in link["href"]: # and link["href"] not in self.ignore:
        links[link["href"]] = base_url2 + link["href"]

    for key, value in links.items():
      file_out = open("html/" + key, 'w')
      url_r = urllib2.urlopen(value).read()
      file_out.write(url_r)
      file_out.close()

  def tidy(self):
    path = self.dir + '/html/'
    filenames = os.listdir(path)
    for name in filenames:
      file_out = "xhtml/{0}.xhtml".format(name.split('.')[0])
      name = path + name
      out = open(file_out, 'w')
      subprocess.Popen(["tidy", "-q", "-asxhtml", "--show-warnings", "n", "--doctype", "omit", "--numeric-entities", "yes", name], stdout=out)
      out.close()

  def extract(self):
    path = self.dir + '/xhtml/'
    filenames = os.listdir(path)
    script = self.dir + '/tools/toXML.xsl'
    for name in filenames:
      file_out = "xml/{0}.xml".format(name.split('.')[0])
      name = path + name
      out = open(file_out, 'w')
      subprocess.Popen(["xsltproc", script, name], stdout=out)
      out.close()

  def convert(self):
    path = self.dir + '/xml/'
    filenames = os.listdir(path)
    script = self.dir + '/tools/toHtml.xsl'
    for name in filenames:
      file_out = "new-html/{0}.html".format(name.split('.')[0])
      name = path + name
      out = open(file_out, 'w')
      subprocess.Popen(["xsltproc", script, name], stdout=out)
      out.close()

  def run(self):
    return 0
    # self.fetch_pages()
    # self.tidy()
    # self.extract()
    # self.convert()

  def time_tidy(self):
    print "----------- Tidy -------------"
    start = time.time()
    self.tidy()
    end = time.time()
    print "Time taken for tidying: ", end-start

  def time_extract(self):
    print "----------- Extract -------------"
    start = time.time()
    self.extract()
    end = time.time()
    print "Time taken for extracting: ", end-start

  def time_convert(self):
    print "----------- Convert -------------"
    start = time.time()
    self.convert()
    end = time.time()
    print "Time taken for converting: ", end-start

  def time_all(self):
    print "----------- All -------------"
    start = time.time()
    self.tidy()
    self.extract()
    self.convert()
    end = time.time()
    print "###################################"
    print "Time taken for ALL: ", end-start
    print "###################################"


    self.delete_files(self.dir+'/xml/')
    self.delete_files(self.dir+'/xhtml/')
    self.delete_files(self.dir+'/new-html/')

  def delete_files(self, top):
    for root, dirs, files in os.walk(top, topdown=False):
      for name in files:
        os.remove(os.path.join(root, name))

if __name__=="__main__":
  eval = Evaluation()
  eval.run()
