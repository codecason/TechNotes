
# e.x. amd64
export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.12.0
curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}

sudo gpg --keyserver keyserver.ubuntu.com --recv-keys 052996E2A20B5C7E
curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt
curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt.asc
sudo gpg -u "Operator SDK (release) <cncf-operator-sdk@cncf.io>" --verify checksums.txt.asc

# ATTENTION: The previous commands don't work!!!

# only install 0.9.0
go env -w GOPROXY="https://goproxy.cn,direct"
git clone https://github.com/operator-framework/operator-sdk
cd operator-sdk
git checkout master
make install

# real version should be >= 1.0
mkdir memcached-operator
cd memcached-operator
operator-sdk new memcached-operator --repo github.com/example/memcached-operator

