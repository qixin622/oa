drop database if exists oa;

CREATE DATABASE `oa` /*!40100 COLLATE 'utf8_general_ci' */;
use oa;

/*==============================================================*/
/* Table: claim_voucher   报销单                                      */
/*==============================================================*/
create table claim_voucher
(
   id                   int not null auto_increment,	-- 编号
   cause                varchar(100),						-- 事由
   create_sn            char(6),								-- 创建人
   create_time          datetime,							-- 创建时间
   next_deal_sn         char(6),								-- 待处理人
   total_amount         double,								-- 总金额
   status               varchar(20),						-- 状态
   primary key (id)
);

/*==============================================================*/
/* Table: claim_voucher_item   报销单明细                                 */
/*==============================================================*/
create table claim_voucher_item
(
   id                   int not null auto_increment,	-- 编号
   claim_voucher_id     int,									-- 报销单编号
   item                 varchar(20),						-- 费用类型
   amount               double,								-- 金额
   comment              varchar(100),						-- 描述
   primary key (id)
);

/*==============================================================*/
/* Table: deal_record       处理记录                            */
/*==============================================================*/
create table deal_record
(
   id                   int not null auto_increment,	-- 编号
   claim_voucher_id     int,									-- 报销单编号
   deal_sn              char(6),								-- 处理人
   deal_time            datetime,							-- 处理时间
   deal_way             varchar(20),						-- 处理类型
   deal_result          varchar(20),						-- 处理结果
   comment              varchar(100),						-- 备注
   primary key (id)
);

/*==============================================================*/
/* Table: department          部门                              */
/*==============================================================*/
create table department
(
   sn                   char(3) not null,	-- 部门编号
   name                 varchar(20),		-- 部门名称
   address              varchar(100),		-- 部门位置
   primary key (sn)
);

/*==============================================================*/
/* Table: employee            员工                              */
/*==============================================================*/
create table employee
(
   sn                   char(6) not null,			-- 员工编号
   password             varchar(50) not null,	-- 员工密码 
   name                 varchar(20) not null,	-- 姓名
   sex						char(2),						-- 性别
   birthday					datetime,					-- 出生日期
   qualification			char(20),					-- 最高学历
   department_sn        char(3),						-- 所属部门
   post                 varchar(20),				-- 职务
   img_url					varchar(255),				-- 头像
   role						varchar(1),					-- 角色：1 管理员 2 普通用户
   primary key (sn)
);


/*==============================================================*/
/* Table: inform            通知                                  */
/*==============================================================*/
create table inform
(
   id                   int not null auto_increment,	-- 编号
   create_sn            varchar(6) not null,			-- 创建人 
   receive_dsn          varchar(3) not null,			-- 接收部门
   create_time				datetime,					-- 创建日期
   inform_content			text,							-- 通知内容
   primary key (id)
);
      
create table inform_record
(
  id                   int not null auto_increment,	-- 编号
  inform_id				  int,									-- 通知id
  read_sn				  varchar(6),							-- 阅读者
  read_time				  datetime,								-- 阅读时间
  primary key (id)
);

alter table claim_voucher add constraint FK_Reference_2 foreign key (next_deal_sn)
      references employee (sn) on delete cascade on update cascade;

alter table claim_voucher add constraint FK_Reference_3 foreign key (create_sn)
      references employee (sn) on delete cascade on update cascade;

alter table claim_voucher_item add constraint FK_Reference_4 foreign key (claim_voucher_id)
      references claim_voucher (id) on delete cascade on update cascade;

alter table deal_record add constraint FK_Reference_5 foreign key (claim_voucher_id)
      references claim_voucher (id) on delete cascade on update cascade;

alter table deal_record add constraint FK_Reference_6 foreign key (deal_sn)
      references employee (sn) on delete cascade on update cascade;

alter table employee add constraint FK_Reference_1 foreign key (department_sn)
      references department (sn) on delete cascade on update cascade;

alter table inform add constraint FK_Reference_7 foreign key (create_sn)
      references employee (sn) on delete cascade on update cascade;
alter table inform add constraint FK_Reference_8 foreign key (receive_dsn)
      references department (sn) on delete cascade on update cascade;
alter table inform_record add constraint FK_Reference_9 foreign key (inform_id)
      references inform (id) on delete cascade on update cascade;
alter table inform_record add constraint FK_Reference_10 foreign key (read_sn)
      references employee (sn) on delete cascade on update cascade;

insert into department values('100','校长办公室','办公楼501');
insert into department values('101','财务部','办公楼203');
insert into department values('102','教务处','第二教学楼201');
insert into department values('103','组织部','办公楼401');
insert into department values('104','宣传部','办公楼402');
insert into department values('105','工会','办公楼403');
insert into department values('106','学工部','学工楼201');
insert into department values('107','人事处','办公楼304');
insert into department values('108','科技务处','办公楼301');
insert into department values('109','研究生处','办公楼302');
insert into department values('110','保卫处','办公楼203');
insert into department values('111','资产管理处','材工大院503');
insert into department values('112','网络中心','第四教教学楼101');

insert into department values('200','电气与信息工程学院','电院大楼501');
insert into department values('300','机械工程学院','机械大楼401');
insert into department values('400','材料科学与工程学院','材工大楼401');
insert into department values('500','汽车工程学院','汽车大院301');
insert into department values('600','经济管理学院','第4教学楼401');
insert into department values('700','马克思主义学院','第3教学楼501');
insert into department values('800','外国语学院','第3教学楼505');
insert into department values('900','理学院','第1教学楼103');
insert into department values('920','继续教育学院','老行政楼301');
insert into department values('940','体育课部','体育馆101');
insert into department values('960','汽车工程师学院','第二实验楼301');

insert into employee values('112001','6f3e9c837428cf739f8ca91bf3b80a59','勾建新','男','1977-12-01','硕士','112','处长','1.jpg','1');
insert into employee values('100001','6f3e9c837428cf739f8ca91bf3b80a59','钟毓宁','男','1977-12-01','硕士','100','校长','3.jpg','0');
insert into employee values('101001','6f3e9c837428cf739f8ca91bf3b80a59','孙峰','男','1977-12-01','硕士','101','处长','3.jpg','0');
insert into employee values('101002','6f3e9c837428cf739f8ca91bf3b80a59','张必桃','女','1977-12-01','硕士','101','会计','4.jpg','0');
insert into employee values('101003','6f3e9c837428cf739f8ca91bf3b80a59','杨丽君','女','1977-12-01','硕士','101','会计','6.jpg','0');
insert into employee values('101004','6f3e9c837428cf739f8ca91bf3b80a59','瞿艳丽','女','1977-12-01','硕士','101','会计','6.jpg','0');
insert into employee values('200001','6f3e9c837428cf739f8ca91bf3b80a59','陈宇峰','男','1977-12-01','硕士','200','院长','2.jpg','0');
insert into employee values('200002','6f3e9c837428cf739f8ca91bf3b80a59','齐心','男','1977-12-01','硕士','200','教师','7.jpg','0');

INSERT INTO `inform` (`id`, `create_sn`, `receive_dsn`, `create_time`, `inform_content`) VALUES
	(1, '200001', '200', '2019-03-04 20:47:55', '各位老师，校职工代表大会即将召开，现在学校正在征集提案。希望各位老师有好的建议可以跟本组的校职工代表提出.'),
	(2, '200001', '200', '2019-03-04 20:48:27', '接宣传部通知：请各单位进一步加强微信、微博、客户端的管理工作，按照工作要求，请不要在群里发与工作无关的事，尤其是转载各种链接。'),
	(3, '200001', '200', '2019-03-04 20:48:44', '请所有补考任务的教师今天要完成所有补考成绩的录入。'),
	(4, '200001', '200', '2019-03-04 20:49:10', '各位老师，请于本周三之前把本单位今年需要结转的本科教学项目经费本交到教科办，以便学校统计今年的结转经费总数并办理结转手续，根据《湖北汽车工业学院本科教学建设与改革项目经费管理办法》规定，2018年获批的校级项目（专业建设项目除外），2017年获批的省级及以上项目在结转的范围内。结转经费统计汇总后，将报送财务处作为今后报销的依据，请各位老师告知本单位教师尽量避免漏报。'),
	(5, '200001', '200', '2019-03-04 20:49:21', '今天下午不开全院大会。院领导2点开始到各系调研，调研顺序：电信、电气、计算机，（计算中心、电工电子）。因为无法预估时间，请两中心等待通知，如果时间不充裕就改日再到中心调研。请各系各中心做好准备~~'),
	(6, '200001', '200', '2019-03-04 20:49:36', '善意提醒：请各系负责毕业设计的主任尽快督促老师们上传课题，目前普教已经上传课题398个，在检查节点时仍然没有上传的，按照规定扣除部分社会工作量。'),
	(7, '200001', '200', '2019-03-04 20:50:09', '电话维修部门通知：电院大楼电话设备出现故障，请大家检查一下自己办公电话是否正常，如果不能拨打，请将电话号码报给我，他们将统一维修。'),
	(8, '200001', '200', '2019-03-04 20:50:23', '各位老师，大家好，2018级转专业学生名单已经在选课系统公示，请查收。'),
	(9, '200001', '200', '2019-03-04 20:50:53', '实践教学科通知 各位老师：关于调整我校毕业设计（论文）相关材料的通知http://jwc.huat.edu.cn/NewsDetail.aspx?NewsID=3801已发送至教务在线，请各位老师及时查看并将通知转发给本单位毕业设计指导教师和全体毕业班学生！'),
	(10, '200001', '200', '2019-03-04 20:51:19', '温馨提示：关于毕业设计课题上传的问题 第一步：大家在“我的课题库”中将课题添加完成; 第二步：要在“我的毕设任务”栏目中单击“准备课题”按钮，在弹出的对话框中选择本次毕业设计要开设的课题。 注意：如果没有做第二步的话，在毕业设计审核栏目中将无法看到老师们上传的课题。');