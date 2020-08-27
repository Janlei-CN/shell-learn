#! /bin/sh
WORKDIR=${CD `dirname $0`;pwd}
# 加载公共配置
. ${WORKDIR}/kjdjb.env
# 加载日志函数
. ${WORKDIR}/logUtil.sh

runLog "-------下发文件自动编译开始--------------"
if [ $# -ne 1]
then
    runLog "参数错误，正确用法： sh doBuild project_name" "ERROR"
if

#PROJECT
if [ ! -n "$1" ]
then
    runLog "PROJECT名未输入" "ERROR"
    exit 1
else
    projectname=$1
fi

# 编译文件
kjdjbXml=kjdjb.xml
xmlPath=${WORKDIR}/${kjdjbXml}

# jenkins先关目录
jksJobPath=${JENKINS_HOME}/jobs
jksWorkPath=${JENKINS_HOME}/workspace

#project相关目录
proJobPath=$jksJobPath/$projectname
proWorkPath=$jksWorkPath/$projectname
buildTaskHome=${PROJHOME}/${projectname}/${xfbh}

# WEBROOT
WEBROOT=${proWorkPath}/WEBRoot

# 进入到Jenkins目录，执行ant进行编译
cd ${jksWorkPath}
$ANTBIN -f ${xmlPath} -Dprojectname=$projectname -Dtomcathome=$TOMCAT_HOME -Djkworkspace=$jksWorkPath jdtduild

# 代码中如果有错误，将返回错误
if [ #? != 0 ]
then
    runLog "====== Ant编译过程中存在错误，可能会影响到部署结果，请在部署完成后进行检查========"  "WARN"
else
    runLog "编译成功" "SUCCESS"
fi
runLog "------ 开发环境自动编译完成 ---------"

# APP安装目录
appBase=/cib/apps
appInstallDir=${appBase}/regist
appxml=${appBase}/config/app.xml
dbxml=${appBase}/config/db-conf.xml
webxml=${appBase}/config/web.xml

runLog "-------- 部署开发环境(全量)------------"
cd ${WEBROOT}
echo "WEBROOT = [${WEBROOT}]"
# 拷贝全部引用到安装目录
rm -rf ${appInstallDir}/*
cp -rf ./* ${appInstallDir}
cp ${appxml} ${appInstallDir}/WEB-INF/class/tws/resources
cp ${dbxml} ${appInstallDir}/WEB-INF/class/tws/resources
cp ${webxml} ${appInstallDir}/WEB-INF/
runLog "------- 部署结束 ----------------"