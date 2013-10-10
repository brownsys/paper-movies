paper-movies
============

Poorly written scripts to animate our papers' revision processes.

The scripts rely on `montage` and `convert` from the ImageMagick suite to
layout the PDFs, and `ffmpeg` to generate the movies. These tools are
cross-platform; it should be possible to use these scripts on Linux (untested)
as well as Mac OS X (tested).

Each script consists of two loops. The first loop ranges over the paper
revisions in the source control repository (which it assumes has been checked-
out) and 1) builds the pdf, then 2) creates a png rendering with the specified
layout. The second loop ranges over the rendered images to prepare them for
ffmpeg.

These scripts were not designed to be generic, drop-in utilities, and are
provided for purposes of illustration. Of course, patches to make them easier
to use and more generic are welcome. :-)


The papers and their revision videos:
---

 * Andrew D. Ferguson, Arjun Guha, Chen Liang, Rodrigo Fonseca, and Shriram
   Krishnamurthi. Participatory Networking: An API for Applicatoin Control of SDNs.
   In Proc. ACM SIGCOMM, August 2013.
    * http://www.cs.brown.edu/~adf/work/SIGCOMM2013-paper.pdf
    * https://www.youtube.com/watch?v=nyLSJjntK6I&hd=1

 * Andrew D. Ferguson, Arjun Guha, Chen Liang, Rodrigo Fonseca, and Shriram
   Krishnamurthi. Hierarchical Policies for Software Defined Networks. In Proc.
   Workshop on Hot Topics in Software Defined Networks (Hot-SDN), August 2012.
    * http://www.cs.brown.edu/~adf/work/HotSDN2012-paper.pdf
    * https://www.youtube.com/watch?v=MIrCSRjqpnA&hd=1
  
 * Andrew D. Ferguson, Arjun Guha, Jordan Place, Rodrigo Fonseca, and Shriram
   Krishnamurthi. Participatory Networking. In Proc. Workshop on Hot Topics in
   Management of Internet, Cloud, and Enterprise Networks and Services
   (Hot-ICE), April 2012.
    * http://www.cs.brown.edu/~adf/work/HotICE2012-paper.pdf
    * https://www.youtube.com/watch?v=6oVqt5sW6qg&hd=1
  
 * Andrew D. Ferguson, Peter Bodik, Srikanth Kandula, Eric Boutin and Rodrigo
   Fonseca. Jockey: Guaranteed Job Latency in Data Parallel Clusters. In ACM
   EuroSys 2012, April 2012.
    * http://www.cs.brown.edu/~adf/work/EuroSys2012-paper.pdf
    * https://www.youtube.com/watch?v=sibJhiDRdSw&hd=1


Author and contact info:
---

Andrew Ferguson  
adf@cs.brown.edu  
http://www.cs.brown.edu/~adf/
