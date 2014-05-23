-- Create table
drop table specimen_pogo cascade constraints ;
create table specimen_pogo
(
  case_id                 varchar2(20),
  specimenid              varchar2(20),
  datecreated             varchar2(25),
  tissuetype              varchar2(30),
  presumedflag            varchar2(20),
  intdeathtoclamptime     number,
  intdeathtoprocstart     number,
  intdeathtochestincision number,
  intheadputonice         number,
  intbrainremovalstart    number,
  intbrainendaliquot      number,
  intdeathtoexcision      number,
  intdeathtofixative      number,
  ischemictimeHHDD        number,
  ischemictime            number,
  collectiontype          varchar2(20),
  bss                     varchar2(20),
  mannerofdeath           varchar2(20),
  causeofdeath            varchar2(75),
  venttime                varchar2(20),
  averagerin              number,
  autolysis               number,
  gender                  varchar2(20),
  age                     number,
  bmi                     number,
  race                    varchar2(40),
  ethnicity               varchar2(40),
  opotype                 varchar2(20),
  hardyscale              number,
  minfixtime              number,
  procedureduration       number
)
;
