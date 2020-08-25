# 日志打印函数
DEFAULTLOGTYPE=INFO
DEFAULTLOGTFILE=tmp.log
# runLog msg type
function runLog()
{
	info="$1"
	type="$DEFAULTLOGTYPE"
	
	# 日志级别
	if [ ! -z $2 ]
	then
		type="$2"
	fi
	
	# 时间格式 2010-08-21 11:13:52
	time="`date +"%Y-%m-%d %H:%M:%S"`"
	
	# 组装错误信息（时间 错误信息）
	errInfo=$time" [$type] - "$info
	# 输出错误信息
	echo $errInfo
}

function fileLog()
{
	info="$1"
	type="$DEFAULTLOGTYPE"
	file="$DEFAULTLOGTFILE"
	
	# 日志文件
	if [ ! -z $2 ]
	then
		file="$2"
	fi
	
	# 日志级别
	if [ ! -z $3 ]
	then 
		type="$3"
	fi
	
	# 时间格式 2010-08-21 11:13:52
	time="`date +"%Y-%m-%d %H:%M:%S"`"
	
	# 组装错误信息（时间 错误信息）
	errInfo=$time" [$type] - "$info
	# 输出错误信息
	echo $errInfo 2>&1 |tee -a ${file}
	
}