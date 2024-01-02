#!/bin/bash
# 아래 명령어를 해당 sh 파일에 적용 실행한다.
# chmod 750 golang_install.sh
# ./golang_install.sh
sudo apt-get update
sudo apt-get -y upgrade
sudo apt install -y git-all

cd /tmp

# 변수 할당 시 공백을 사용하지 않고, 변수를 사용할 때는 $를 사용
# 다운 가능한 go 버전을 입력함
go="go1.17.2.linux-amd64.tar.gz"

# go 다운로드
wget https://dl.google.com/go/${go}

# 다운받은 go 파일의 압축을 푼다
sudo tar -C /usr/local -xzf ${go}

# 파일을 삭제하는 것은 tar 명령 이후에 수행
sudo rm -rf /tmp/${go}

# GOROOT와 GOPATH 환경 변수 추가
echo 'export GOROOT=/usr/local/go' >> ~/.profile
echo "export GOPATH=$HOME/go" >> ~/.profile

# ~/.profile 파일이 존재하는지 확인
if [ -f ~/.profile ]; then
    # PATH에 GOPATH/bin과 GOROOT/bin이 이미 포함되어 있는지 확인
    if ! grep -q "GOPATH/bin" ~/.profile || ! grep -q "GOROOT/bin" ~/.profile; then
        echo "Updating PATH in ~/.profile"

        # 기존 PATH 끝에 추가
        echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> ~/.profile
    else
        echo "PATH already contains GOPATH/bin and GOROOT/bin"
    fi
else
    # ~/.profile 파일이 존재하지 않는 경우, 새로 생성
    echo "Creating ~/.profile and setting PATH"
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' > ~/.profile
fi

# 스크립트에서 source 명령은 권장되지 않음
# 해당 스크립트 완료후 source ~/.profile 실행

