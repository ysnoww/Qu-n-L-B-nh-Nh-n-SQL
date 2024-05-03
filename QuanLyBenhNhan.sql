﻿create database QUANLYBENHNHAN

create table BenhNhan(
   MaBN varchar(10) constraint PK_BN primary key, 
   Họ nvarchar(50),
   Tên nvarchar(50),
   Ngaysinh DATE,
   Địachỉ nvarchar(100),
   Sdt varchar(50),
   giớitính nvarchar(10),
   Bảohiểmytế nvarchar(50) 
)
go

create table ThanNhan(
   MaBN varchar(10) not null constraint FK_BN3  foreign key(MaBN)  references [dbo].[BenhNhan](MABN),
   Họ nvarchar(50),
   Tên nvarchar(50),
   DịaChỉ nvarchar(100),
   GiớiTính nvarchar(10),
   MốiQuanHệ nvarchar(10)
);
go

create table HồSơBệnhÁn(
MaHS varchar(10) constraint PK_HS primary key,
MaP varchar(10) not null, -- thieu
MaPNV varchar(10) not null,
MaBN varchar(10) not null constraint PK_MaBN foreign key references [dbo].[BenhNhan](MaBN),
ChuanDoan nvarchar(500),
PhươngPhápDiềuTrị nvarchar(500)
);
alter table [dbo].[HồSơBệnhÁn]
add constraint FK_MaP2 foreign key ([MaP])
references [dbo].[Phòng](MaP);

alter table [dbo].[HồSơBệnhÁn]
add constraint FK_MaPNV foreign key([MaPNV])
references [dbo].[PhiếuNhậpViện](MaPNV);

create table PhiếuXuấtViện(
MaPXV varchar(10) constraint PK_PXV primary key,
NgàyXuấtViện date,
MaHS varchar(10) constraint FK_HS foreign key references[dbo].[HồSơBệnhÁn](MaHS)
);

create table DịchVụ (
 MaDV varchar(10) constraint PK_DV primary key,
 TênDịchVụ nvarchar(50),
 Giá float
);
--alter table [dbo].[DịchVụ]
--drop constraint [FK__DịchVụ__MaBN__5812160E];

create table BệnhNhân_DịchVụ(
    MaBN varchar(10) not null constraint FK_BN foreign key references [dbo].[BenhNhan](MaBN),
	MaDV varchar(10) not null constraint FK_DV foreign key references [dbo].[DịchVụ](MaDV),
	NgàySửDụng date
);

drop table [dbo].[BệnhNhân_DịchVụ]
--create table ĐơnThuốc_Thuốc(
--);

create table Thuốc(
MaT varchar(10) constraint PK_T primary key,
MaDT varchar(10) not null ,
TênThuốc varchar(50) not null,
HDSD nvarchar(500) not null,
LiềuLượng nvarchar(50) not null,
Giá float
);

create table ChiTiếtHóaĐơn(
MaHD varchar(10) not null constraint FK_MaHD foreign key references [dbo].[HóaĐơn](MaHD),
TiềnKhám float,
MaDV varchar(10) not null constraint FK_MaDV foreign key references [dbo].[DịchVụ](MaDV),
MaT varchar(10) not null constraint FK_MaT foreign key references [dbo].[Thuốc](MaT)
);

create table HóaĐơn(
MaHD varchar(10) constraint PK_MaHD primary key,
MaBN varChar(10) not null constraint FK_MaBN foreign key references  [dbo].[BenhNhan](MaBN),
NgàyHạn date,
TổngTiền float
);

create table ĐơnThuốc (
MaDT varchar(10) constraint PK_MaDT primary key,
MaBS varchar(10) not null,
MaHS varchar(10) not null,
NgàyKêĐơn varchar(10) not null,
GiáĐơnThuốc float
);
Alter table [dbo].[ĐơnThuốc]
add constraint FK_BS3 foreign key ([MaBS])
references [dbo].[BácSĩ](MaBS);

Alter table [dbo].[ĐơnThuốc]
add constraint FK_HS2 foreign key ([MaHS])
references [dbo].[HồSơBệnhÁn](MaHS);


create table ĐơnThuốc_Thuốc(
MaDT varchar(10) not null constraint FK_MaDT foreign key references [dbo].[ĐơnThuốc](MaDT),
MaT varchar(10) not null constraint FK_T foreign key references [dbo].[Thuốc](MaT),
SốLượng int
);

create table BácSĩ(
MaBS varchar(10) constraint PK_BS primary key,
Họ nvarchar(50) not null,
Tên nvarchar(50) not null,
SDT varchar(20),
ĐịaChỉ nvarchar(50) 
);

create table Khoa(
MaK varchar(10) constraint PK_K primary key,
MaTK varchar(10) not null constraint FK_BS foreign key references [dbo].[BácSĩ](MaBS),
TênKHoa nvarchar(50) not null
);

create table Phòng(
MaP varchar(10) constraint PK_P primary key,
MaK varchar(10) not null constraint FK_K foreign key references [dbo].[Khoa](MaK),
TênPhòng nvarchar(10),
LoạiPhòng nvarchar(10),
ĐịaChỉ nvarchar(10)
);

create table Phòng_BácSĩ(
MaP varchar(10) not null constraint FK_P foreign key references [dbo].[Phòng](MaP),
MaBS varchar(10) not null constraint FK_BS1  foreign key references [dbo].[BácSĩ](MaBS),
PhụTrách nvarchar(10)
);

create table PhiếuNhậpViện(
MaPNV varchar(10) constraint PK_PNV primary key,
NgàyNhậpViện date,
MaP varchar(10) constraint FK_P2 foreign key references [dbo].[Phòng](MaP)
);

create table Phòng_BN(
MaP varchar(10) constraint FK_P3 foreign key references [dbo].[Phòng](MaP),
MaBN varchar(10) constraint FK_MaBN1 foreign key references [dbo].[BenhNhan](MaBN),
ThờiGianKhám date,
ThờiGianĐiềuTrị date
);

create table BácSĩ_HồSơBệnhÁn(
MaBS varchar(10) constraint FK_BS2 foreign key references [dbo].[BácSĩ](MaBS),
MaHS varchar(10) constraint FK_HS1 foreign key references [dbo].[HồSơBệnhÁn](MaHS),
KhámBệnh nvarchar(10),
Điềutrị nvarchar(10)
);
jdfhjsbfuf
