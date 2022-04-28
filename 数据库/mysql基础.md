## mysql 安装/卸载
mysql 安装  
```
查看有没有安装mysql
dpkg -l | grep mysql  
```
安装
```

   sudo apt-get install mysql-server -y
   sudo apt install mysql-client  -y
   sudo apt install libmysqlclient-dev -y
//查看检查是否安装成功
netstat -tap | grep mysql
```  

查看mysql服务运行是否正常
```
systemctl status mysql
```  
mysql查看权限表
```
use mysql;
select host,user,authentication_string,plugin from user;

//添加远程访问账号
create user 'phdb_user'@'%' identified by '123456';
grant all privileges on *.* to 'phdb_user'@'%';
alter user 'phdb_user'@'%' identified with mysql_native_password by '123456';
flush privileges;
```

配置mysql允许远程访问
```
vim /etc/mysql/mysql.conf.d/mysqld.cnf  
注释掉bing-address 那行,保存退出

重启服务
service mysql restart
```
mysql 卸载
```
apt purge mysql-*;
rm -rf /etc/mysql /var/lib/mysql
apt autoremove
apt autoclean
```


## mysql语法,存储过程
```

delimiter //;
CREATE PROCEDURE update_seal_apply_code (
	IN creditApplyId VARCHAR ( 40 )) BEGIN
	DECLARE
		done boolean DEFAULT 0;
	DECLARE
		tmpNumber INT DEFAULT 1;
	DECLARE
		creditSealApplyId VARCHAR ( 40 );
	DECLARE
		creditSealApply CURSOR FOR SELECT
		id 
	FROM
		credit_seal_apply 
	WHERE
		credit_seal_apply.credit_apply_id = creditApplyId;
	DECLARE
		CONTINUE HANDLER FOR SQLSTATE '02000' 
		SET done = 1;
	OPEN creditSealApply;
	REPEAT
			FETCH creditSealApply INTO creditSealApplyId;
		UPDATE credit_seal_apply 
		SET seal_apply_code = CONCAT( credit_contract_code, '-', tmpNumber ) 
		WHERE
			id = creditSealApplyId;
	set	tmpNumber = tmpNumber + 1;
		UNTIL done 
	END REPEAT;
	CLOSE creditSealApply;
	
END //;

delimiter ;

delimiter //;
CREATE PROCEDURE real_update_credit_seal_apply_code () BEGIN
	DECLARE
		done boolean DEFAULT 0;
	DECLARE
		tempId VARCHAR ( 40 );
	DECLARE
		creditApplyId CURSOR FOR SELECT
		credit_apply_id 
	FROM
		credit_seal_apply 
	GROUP BY
		credit_apply_id;
	DECLARE
		CONTINUE HANDLER FOR SQLSTATE '02000' 
		SET done = 1;
	OPEN creditApplyId;
	REPEAT
			FETCH creditApplyId INTO tempId;
		CALL update_seal_apply_code ( tempId );
		UNTIL done 
	END REPEAT;
	CLOSE creditApplyId;
END //;
delimiter ;

call real_update_credit_seal_apply_code();

drop PROCEDURE update_seal_apply_code;
drop PROCEDURE real_update_credit_seal_apply_code;
```

## mysql 语句
### 查看表的字段
```
select GROUP_CONCAT(COLUMN_NAME) from information_schema.COLUMNS where table_name = 'activity_info';  
```
### 日期
```sql
-- 加天数
DATE_ADD(approve_stamp_date,INTERVAL apply_term MONTH)
```

### mysql执行sql脚本
```
登录到mysql命令行
mysql -uxxxx -p

然后
source F:\hello world\niuzi.sql
```
