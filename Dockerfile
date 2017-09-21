FROM centos:7

MAINTAINER Bruno Dias <contato@diasbruno.com>

USER root 

ADD config/* /
ENV ORACLE_HOME="/u01/app/oracle/product/11.2.0/xe" ORACLE_SID="XE" PATH="$ORACLE_HOME/bin:$PATH" 

# Create fake swap info on free command and install Oracle-xe 11g
RUN mv /usr/bin/free /usr/bin/free.orig \
  && bash /fakeswap.sh \
  && rm /fakeswap.sh \
  && yum install -y net-tools initscripts wget unzip libaio bc --nogpgcheck \ 
  && yum clean all \
  && wget https://raw.githubusercontent.com/Vincit/travis-oracledb-xe/master/packages/oracle-xe-11.2.0-1.0.x86_64.rpm.zip.aa \
  && wget https://raw.githubusercontent.com/Vincit/travis-oracledb-xe/master/packages/oracle-xe-11.2.0-1.0.x86_64.rpm.zip.ab \
  && wget https://raw.githubusercontent.com/Vincit/travis-oracledb-xe/master/packages/oracle-xe-11.2.0-1.0.x86_64.rpm.zip.ac \
  && wget https://raw.githubusercontent.com/Vincit/travis-oracledb-xe/master/packages/oracle-xe-11.2.0-1.0.x86_64.rpm.zip.ad \
  && cat oracle-xe-11.2.0-1.0.x86_64.rpm.zip.* > oracle-xe-11.2.0-1.0.x86_64.rpm.zip \
  && unzip oracle-xe-11.2.0-1.0.x86_64.rpm.zip \
  && rpm -ivh --ignoreos Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm \
  && mv /usr/bin/free.orig /usr/bin/free \
  && rm -rf oracle-xe-11.2.0-1.0.x86_64.rpm* Disk1/ \
  && yum remove -y wget unzip \
  && yum autoremove -y \
  && mv /xe.rsp /*.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/ \
  && chown oracle:dba /u01/app/oracle/product/11.2.0/xe/config/scripts/* \
  && chmod 755 /u01/app/oracle/product/11.2.0/xe/config/scripts/* \
  && /etc/init.d/oracle-xe configure responseFile=/u01/app/oracle/product/11.2.0/xe/config/scripts/xe.rsp \
  && ln -s $ORACLE_HOME/bin/sqlplus /bin/sqlplus

EXPOSE 1521 8080

ADD create-users.sql /
ADD docker-entrypoint.sh /

# Run oracle-xe
ENTRYPOINT ["bash", "docker-entrypoint.sh"]
