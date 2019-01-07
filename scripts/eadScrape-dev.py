from bs4 import BeautifulSoup
import urllib.request as urllib2
import urllib.parse
import simplejson
import difflib
import filecmp
import pysolr
import datetime

# start report
ts = datetime.datetime.now().strftime("%A, %d. %B %Y %I:%M%p")
report = open("fa-2-isl.txt","a")
report.write('\n\n')
report.write("Report started at %s \nComparing EADs...\n" % ts)

# get ready to drown in poorly named variables

solr = pysolr.Solr('http://backend.hagley.dgicloud.com:8080/solr/')
flarr = ['PID,mods_recordInfo_recordIdentifier_t'] # fields to pass to solr

results = solr.search('RELS_EXT_isMemberOfCollection_uri_t:("islandora:ead")',wt='python',fl=flarr, rows=1200) #assign query results
# make a list of xtf-based finding aids
html_page = ("https://findingaids.hagley.org/xtf/data/ead/")
page = urllib2.urlopen(html_page)
soup = BeautifulSoup(page, 'lxml')
falist = []
for f in soup.table.find_all('a'):
    falist.append(f.attrs['href'])
faead_list = []
for faead in falist:
    f1 = faead.replace('.xml','')
    f2 = f1.replace('_','.')
    faead_list.append(f2.replace('/xtf/data/ead/',''))

# make a list of records from solr
isl_list = []
for m in results:
    isl_list.append(m['mods_recordInfo_recordIdentifier_t'])


# pull and compare ead files
for result in results:
    try:
        islfa = result['PID']
        fa = result['mods_recordInfo_recordIdentifier_t']
        facn = fa.replace(':','_')
        faxml = facn.replace('.','_')
        ead_filename = faxml + ".xml"
        faxml_url = "https://findingaids.hagley.org/xtf/data/ead/" + ead_filename
        islfa_url = "https://digital.hagley.org/islandora/object/" + islfa + "/datastream/EAD/view"
        fa_compare = urllib2.urlopen(faxml_url)
        islfa_compare = urllib2.urlopen(islfa_url)
        fadl = fa_compare.read()
        islfadl = islfa_compare.read()
        fastr = fadl.decode("utf8")
        islfastr = islfadl.decode("utf8")
        if fastr != islfastr:
            nqreport = "%s is not equal to %s" % (faxml, islfa) + '\n'
            report.write(nqreport)
    except:
        nfreport = "%s is not found." % faxml + '\n'
        report.write(nfreport)

# junk entries
FAmismatch = ["LMSS.III","LMSS.I","LMSS.II","LMSS.IV","LMSS.VI","1359.part.II","1665.strip","WMSS.IX","20100108.ZTV.XXV"]

# compare lists of finding aids
def Diff(faead_list,isl_list):
    return(list(set(faead_list) - set(isl_list)))

fadiff = Diff(faead_list,isl_list)

# and list to junk
def Diff (fadiff,FAmismatch):
	return(list(set(fadiff) - set(FAmismatch)))

fadiffreg = Diff(fadiff, FAmismatch)

fadiffClean = "\n".join(fadiffreg)
report.write("\nNew EAD:\n%s" % fadiffClean)
# and finish
report.write('\n'+ "====== Report Complete: %s ======" % ts)
report.close()
