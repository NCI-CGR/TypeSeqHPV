#+

install_binaries <- function(...){

system("apt-get update")
system("apt-get install -y texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra")

system("wget https://github.com/jgm/pandoc/releases/download/2.0.1.1/pandoc-2.0.1.1-1-amd64.deb \
&& dpkg -i pandoc-2.0.1.1-1-amd64.deb")

#https://github.com/biod/sambamba
system("wget https://github.com/biod/sambamba/releases/download/v0.6.7/sambamba_v0.6.7_linux.tar.bz2
tar xvjf sambamba_v0.6.7_linux.tar.bz2")

}
