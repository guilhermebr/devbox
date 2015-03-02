from kdelfour/cloud9-docker
maintainer Guilherme Rezende <guilhermebr@gmail.com>

run apt-get update -y
# run apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev
run apt-get install -y python python-dev python-setuptools python-virtualenv
run apt-get install -y postgresql-client libpq-dev 
run apt-get install -y mercurial
run apt-get install -y curl
run apt-get install -y vim
run apt-get install -y strace
run apt-get install -y diffstat
run apt-get install -y pkg-config
run apt-get install -y cmake
run apt-get install -y tcpdump
run apt-get install -y screen

# Install go
run curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C /usr/local -zx
env GOROOT /usr/local/go
env PATH /usr/local/go/bin:$PATH

# .ssh
run mkdir /root/.ssh
volume /root/.ssh

# Setup home environment
run mkdir -p /root/go /root/bin /root/lib /root/include
env PATH /root/bin:$PATH
env PKG_CONFIG_PATH /root/lib/pkgconfig
env LD_LIBRARY_PATH /root/lib
env GOPATH /root/go:$GOPATH

# run go get github.com/dotcloud/gordon/pulls

workdir /root

env HOME /root
add vimrc /root/.vimrc
add vim /root/.vim
add bash_profile /root/.bash_profile
add gitconfig /root/.gitconfig

# Clean up APT when done.
run apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

expose 8080
expose 3000

