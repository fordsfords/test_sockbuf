# semlit
test_sockbuf

test_sockbuf is a simple project which reproduces the first two sets of
results shown at:
http://blog.geeky-boy.com/2014/02/socket-buffers-more-complicated-than.html

The project is based on modified versions of the Informatica "mtools" programs
"msend" and "mdump".  The original mtools can be found at:
https://community.informatica.com/solutions/informatica_mtools
My modifications are in this project.

## License

Informatica was nice enough to put their "msend" and "mdump" tools
into something resembling the public domain.  Here is what the tools
have to say:

<pre>
Author: J.P.Knight@lut.ac.uk (heavily modified by 29West/Informatica)

Redistribution and use in source and binary forms, with or without
modification, are permitted without restriction.

Note: this program is based on the sd_listen program by Tom Pusateri
(pusateri@cs.duke.edu) and developed by Jon Knight (J.P.Knight@lut.ac.uk).

THE SOFTWARE IS PROVIDED "AS IS" AND INFORMATICA DISCLAIMS ALL WARRANTIES
EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF
NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR
PURPOSE.  INFORMATICA DOES NOT WARRANT THAT USE OF THE SOFTWARE WILL BE
UNINTERRUPTED OR ERROR-FREE.  INFORMATICA SHALL NOT, UNDER ANY CIRCUMSTANCES,
BE LIABLE TO LICENSEE FOR LOST PROFITS, CONSEQUENTIAL, INCIDENTAL, SPECIAL OR
INDIRECT DAMAGES ARISING OUT OF OR RELATED TO THIS AGREEMENT OR THE
TRANSACTIONS CONTEMPLATED HEREUNDER, EVEN IF INFORMATICA HAS BEEN APPRISED OF
THE LIKELIHOOD OF SUCH DAMAGES.
</pre>

## Tool Modifications

The modifications I made to the tools are similarly offered in a
public domain style.

My primary modifications were to mdump to allow it to be used in an
automated way.  A signal handler for SIGALRM is central to the
automation.  (Both tools were changed a bit to fine-tune the output.)

The "tst.sh" script orchestrates the test.  It runs mdump in the background,
which initializes and then waits for a SIGALRM.  But mdump does not yet
call "alarm()", so it will wait forever for SIGALRM.  Meanwhile, the
tst.sh script runs msend.  When that finishes, it does a "kill -ALRM" to
the mdump process.  This causes mdump's SIGLARM handler to run, which
starts the receive process to happen.  It also sets an alarm(1) going.
When mdump reads the socket dry, "num_msgs" stops increasing, and the
signal handler prints the results and exits.

## Usage

You will need to change it according to your hosts.  My hosts are named
"saturn" and "orion", and their desired interface IP addresses are 10.29.3.42
and 10.29.3.43 respectively.  I run "tst.sh" on Saturn, and the script uses
"ssh" to run "mdump" on orion.  (I have it set up for password-free login.)

First, run "./bld.sh" to build the tools.  Then modify "./tst.sh" to your
environment and run it.

Note that tst.sh assumes that your "orion" machine has the same
discontinuities described in the
[blog post](http://blog.geeky-boy.com/2014/02/socket-buffers-more-complicated-than.html)
Your machine will almost certainly have different ones.  You'll need to
use a "binary search" of different datagram sizes (the "-m" option on msend)
to find your discontinuity points.
The obsessive among you might even want to write a perl or python script to
find those points automatically.
