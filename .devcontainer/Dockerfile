FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# install general packages
RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list &&\
    apt-get update && \
    apt-get install -y  \
      build-essential \
      cpanminus \
      git \
      curl \
      wget \
      locales && \
    # clean to reduce image size
    apt-get clean -y && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/*

# install texlive
RUN mkdir /tmp/install-tl-unx && \
    curl -O -L http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -zxvf install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components 1  &&\
    printf "%s\n" \ 
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      "option_autobackup 0" \
      "option_adjustrepo 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    ./tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    rm -rf /tmp/install-tl-unx

# add TeX Live to PATH
ENV PATH /usr/local/bin/texlive:$PATH

# install LaTeX packages with tlmgr
RUN ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive
RUN tlmgr install \
    latexmk \
    latexindent \
    collection-latexextra \
    collection-fontsextra \
    collection-fontsrecommended \
    collection-langjapanese \
    siunitx \
    # lualatexでstandaloneクラスをビルドするときに必要
    # luatex85 

# その他必要なものをインストール
RUN apt update &&\
    apt install texlive-extra-utils -y &&\
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg &&\
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null &&\
    apt update &&\
    # inkscapeで作成したsvgを読み込むのに必要
    # apt-get install inkscape -y &&\
    apt install gh -y

# COPY .latexmkrc /root

# install perl packages which are requirements of "latexindent"
RUN cpanm Log::Log4perl Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString

WORKDIR /workdir

CMD ["bash"]