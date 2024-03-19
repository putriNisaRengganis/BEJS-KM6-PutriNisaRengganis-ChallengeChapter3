create database ch3_challenge;
/*CREATE DATABASe
\c ch3_challenge
You are now connected to database "ch3_challenge" as user "postgres".
*/

CREATE TYPE jenis_kelamin AS ENUM('laki-laki','perempuan');
CREATE TYPE
CREATE TYPE status_akun AS ENUM('Aktif','Tidak Aktif');
CREATE TYPE

create table nasabah(
id bigserial primary key,
nama varchar(255) not null,
alamat text not null,
nomor_identitas text not null,
nomor_telepon varchar(255) not null,
email varchar(255) not null,
jenis_kelamin jenis_kelamin,
status_akun status_akun
 );
/*CREATE TABLE
 \dt

        List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | nasabah | table | postgres
(1 row)
 select*from nasabah;
 id | nama | alamat | nomor_identitas | nomor_telepon | email | jenis_kelamin | status_akun
----+------+--------+-----------------+---------------+-------+---------------+-------------
(0 rows)
*/
create table akun(
 id bigserial primary key,
 nama varchar(255) not null,
 saldo integer not null,
 no_rekening varchar(50) not null unique,
 pin integer not null,
 id_nasabah integer references nasabah(id) not null
 );
/*CREATE TABLE*/
select*from akun;

/*
 id | nama | saldo | no_rekening | pin | id_nasabah
----+------+-------+-------------+-----+------------
(0 rows)
 \dt
        List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | akun    | table | postgres
 public | nasabah | table | postgres
(2 rows)
*/

create table transaksi(
 id bigserial primary key,
 jenis_transaksi varchar(255) not null,
 nominal integer not null,
 keterangan varchar(255) not null,
 tanggal timestamp not null,
 id_akun integer references akun(id) not null
 );
/*CREATE TABLE*/
 select*from transaksi;
/*
 id | jenis_transaksi | nominal | keterangan | tanggal | id_akun
----+-----------------+---------+------------+---------+---------
(0 rows)
 \dt
          List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | akun      | table | postgres
 public | nasabah   | table | postgres
 public | transaksi | table | postgres
(3 rows)
*/
--CRUD--

--INSERT--
insert into nasabah (nama,alamat,nomor_identitas,nomor_telepon,email,jenis_kelamin,status_akun)
values('Putri Nisa Rengganis','jln.panyingkiran Sumedang','32111187896532',0895414842641,'putrinisarengganis@gmail.com','perempuan','Aktif');
/*INSERT 0 1*/
 select*from nasabah;
/*
 id |         nama         |          alamat           | nomor_identitas | nomor_telepon |            email             | jenis_kelamin | status_akun
----+----------------------+---------------------------+-----------------+---------------+------------------------------+---------------+-------------
  1 | Putri Nisa Rengganis | jln.panyingkiran Sumedang | 32111187896532  | 895414842641  | putrinisarengganis@gmail.com | perempuan     | Aktif
(1 row)
*/
insert into akun (nama,saldo,no_rekening,pin,id_nasabah)
values('Putri Nisa Rengganis',2000000,'016601020870538',950465,1);
/*INSERT 0 1
*/
 select*from akun;
/* id |         nama         |  saldo  |   no_rekening   |  pin   | id_nasabah
----+----------------------+---------+-----------------+--------+------------
  1 | Putri Nisa Rengganis | 2000000 | 016601020870538 | 950465 |          1
(1 row)
*/
 insert into transaksi (jenis_transaksi,nominal,keterangan,tanggal,id_akun)
 values('Transfer',10000,'transfer bank',now(),1);
/*INSERT 0 1*/
 select*from transaksi;
/* id | jenis_transaksi | nominal |  keterangan   |          tanggal           | id_akun
----+-----------------+---------+---------------+----------------------------+---------
  1 | Transfer        |   10000 | transfer bank | 2024-03-19 13:48:47.982315 |       1
(1 row)*/

--UPDATE--
update akun set saldo = 1500000 where id=1;
/*UPDATE 18*/
select*from akun;
/* id |         nama         |  saldo  |   no_rekening   |  pin   | id_nasabah
----+----------------------+---------+-----------------+--------+------------
  1 | Putri Nisa Rengganis | 1500000 | 016601020870538 | 950465 |          1
(1 row)*/

--RELASI--
select*from nasabah inner join akun on nasabah.id = akun.id_nasabah
inner join transaksi on akun.id = transaksi.id_akun;
/* id |         nama         |          alamat           | nomor_identitas | nomor_telepon |            email             | jenis_kelamin | status_akun | id |         nama         |  saldo  |   no_rekening   |  pin   | id_nasabah | id | jenis_transaksi | nominal |  keterangan   |          tanggal           | id_akun
----+----------------------+---------------------------+-----------------+---------------+------------------------------+---------------+-------------+----+----------------------+---------+-----------------+--------+------------+----+-----------------+---------+---------------+----------------------------+---------
  1 | Putri Nisa Rengganis | jln.panyingkiran Sumedang | 32111187896532  | 895414842641  | putrinisarengganis@gmail.com | perempuan     | Aktif       |  1 | Putri Nisa Rengganis | 1500000 | 016601020870538 | 950465 |          1 |  1 | Transfer        |   10000 | transfer bank | 2024-03-19 13:48:47.982315 |       1
(1 row)*/

--DELETE--
delete from transaksi where id =1;
DELETE 1
select*from transaksi;
/* id | jenis_transaksi | nominal | keterangan | tanggal | id_akun
----+-----------------+---------+------------+---------+---------
(0 rows)*/