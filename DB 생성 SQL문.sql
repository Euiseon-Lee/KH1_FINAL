CREATE TABLE member (
	member_no	number		NOT NULL,
	attachment_no	number		NOT NULL,
	member_email	varchar2(100)		NOT NULL,
	member_pw	varchar2(30)		NOT NULL,
	member_nick	varchar2(30)		NOT NULL,
	member_holding_points	number		NOT NULL,
	member_available_time	char(4)		NOT NULL,
	member_grade	varchar2(12)		NOT NULL,
	member_red_count	number	DEFAULT 0	NOT NULL,
	member_joindate	Date		NOT NULL,
	member_logintime	Date		NULL
);
    
COMMENT ON COLUMN member.member_grade IS '블랙회원
일반회원
관리자';

COMMENT ON COLUMN member.member_logintime IS '처음 로그인 할 땐 null이니까 가능';


alter table member add (member_name varchar2(51));
alter table member add (member_sex char(1));
alter table member add (member_birth Date);

alter table member modify member_name not null;
alter table member modify member_sex not null;
alter table member modify member_birth not null;


CREATE TABLE auction (
	auction_no	number		NOT NULL,
	auctioneer_no	number		NOT NULL,
	category_no	number		NOT NULL,
	auction_title	varchar2(90)		NOT NULL,
	auction_content	varchar2(300)		NOT NULL,
	auction_upload_time	Date	DEFAULT sysdate	NOT NULL,
	auction_closed_time	Date		NOT NULL,
	auction_opening_bid	number		NOT NULL,
	auction_closing_bid	number		NULL,
	auction_bid_unit	number		NOT NULL,
	auction_status	number		NOT NULL
);

COMMENT ON COLUMN auction.auction_status IS '1~5
5 미개봉신제품
0 이걸 팔아?';

CREATE TABLE attachment (
	attachment_no	number		NOT NULL,
	attachment_uploadname	varchar2(60)		NOT NULL,
	attachment_savename	varchar2(60)		NOT NULL,
	attachment_type	varchar2(10)		NOT NULL,
	attachment_size	number		NOT NULL
);

CREATE TABLE chatroom (
	chatroom_no	number		NOT NULL,
	participator_no	number		NOT NULL,
	auction_no	number		NOT NULL
);

CREATE TABLE bidding (
	bidder_no	number		NOT NULL,
	auction_no	number		NOT NULL,
	bidding_price	number		NOT NULL,
	bidding_time	Date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE cashing_points (
	member_no	number		NOT NULL,
	cashing_money	number		NOT NULL,
	cashing_bank	varchar2(35)		NOT NULL,
	cashing_account	number		NOT NULL,
	cashing_type	char(1)		NOT NULL,
	cashing_status	varchar2(12)	DEFAULT 0	NOT NULL,
	cashing_request_time	Date	DEFAULT sysdate	NOT NULL,
	cashing_success_time	Date		NULL
);

COMMENT ON COLUMN cashing_points.cashing_money IS '현재 보유 포인트보다 높은 숫자가 들어가면 거부';

COMMENT ON COLUMN cashing_points.cashing_status IS '0- 출금신청 / 1- 출금완료 / 2- 출금처리중 / 3- 출금보류';

COMMENT ON COLUMN cashing_points.cashing_success_time IS '현금화 승인시 sysdate으로 들어감';

CREATE TABLE photo (
	photo_no	number		NOT NULL,
	photo_auction_no	number		NOT NULL,
	photo_attachment_no	number		NOT NULL
);

CREATE TABLE category (
	category_no	number		NOT NULL,
	category_name	varchar2(30)		NOT NULL
);

CREATE TABLE member_rating (
	rating_no	number		NOT NULL,
	rating_item_no	number		NOT NULL,
	auction_no	number		NOT NULL
);

CREATE TABLE rating (
	rating_item_no	number		NOT NULL,
	rating_sort_no	char(1)		NOT NULL,
	rating_content	varchar2(100)		NOT NULL
);

CREATE TABLE chat_content (
	chat_no	number		NOT NULL,
	chatroom_no	number		NOT NULL,
	chatter_no	number		NOT NULL,
	chat_content	varchar2(300)		NOT NULL,
	chat_time	Date		NOT NULL,
	chat_reported	char(1)	DEFAULT 0	NOT NULL,
	chat_read_time	Date		NULL
);

COMMENT ON COLUMN chat_content.chat_reported IS '0 - 신고 x
1 - 신고 o';

CREATE TABLE net_sales (
	succ_bid_no	REFERENCES successful_bid (succ_bid_no),
	commission	number		NOT NULL,
	net_sales_time	Date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE gps_address (
	gps_no	number		NOT NULL,
	member_no	number		NOT NULL,
	gps_latitude	number		NOT NULL,
	gps_longitude	number		NOT NULL,
	gps_regist_time	Date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE chat_report (
	chat_report_no	number		NOT NULL,
	chat_no	number		NOT NULL,
	chat_reporter_no	number		NOT NULL,
	chat_report_reason	varchar2(300)		NOT NULL,
	chat_report_time	Date	DEFAULT sysdate	NOT NULL
);

CREATE TABLE manager_restriction (
	restriction_no	number		NOT NULL,
	member_no	number		NOT NULL,
	restriction_reason	varchar(300)		NOT NULL,
	restriction_type	number		NOT NULL,
	restriction_time	Date	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN manager_restriction.restriction_type IS '0- 채팅 / 1- 허위매물 / 2- 기타(관리자 채팅으로 욕설 등)';

CREATE TABLE payment (
	payment_no	number		NOT NULL,
	member_no	number		NOT NULL,
	payment_tid	varchar2(20)		NOT NULL,
	payment_price	number		NOT NULL,
	payment_time	Date	DEFAULT sysdate	NOT NULL,
	payment_status	varchar2(12)	DEFAULT 0	NOT NULL
);

COMMENT ON COLUMN payment.payment_status IS '0-취소/1-완료';

CREATE TABLE auction_report (
	auction_report_no	number		NOT NULL,
	auction_no	number		NOT NULL,
	auction_reporter_no	number		NOT NULL,
	auction_report_reason	varchar2(300)		NOT NULL,
	auction_report_time	Date	DEFAULT sysdate	NULL
);

CREATE TABLE chatbot (
	chatbot_no	number		NOT NULL,
	chatbot_content	varchar2(300)		NOT NULL,
	chatbot_super_no	number		NOT NULL
);

CREATE TABLE category_photo (
	category_no	number		NOT NULL,
	attachment_no	number		NOT NULL
);

CREATE TABLE successful_bid (
	succ_bid_no	number		NOT NULL primary key,
	auction_no	number		NOT NULL,
	succ_bidder_no	number		NOT NULL,
	succ_final_bid	number		NOT NULL,
	succ_auctioneer_approve	Date		NULL,
	succ_bidder_approve	Date		NULL,
	succ_date	Date	DEFAULT sysdate	NOT NULL,
	succ_bid_status	number	DEFAULT 0	NOT NULL,
	succ_auction_count	number		NOT NULL
);

COMMENT ON COLUMN successful_bid.succ_auctioneer_approve IS '버튼 누르면 sysdate으로 update';

COMMENT ON COLUMN successful_bid.succ_bidder_approve IS '버튼 누르면 sysdate으로 update';

COMMENT ON COLUMN successful_bid.succ_bid_status IS '0 결제 예정
1 결제 완료
2 미결제';

CREATE TABLE tos (
	tos_no	number		NOT NULL,
	tos_content	varchar2(4000)		NOT NULL,
	tos_valid	number		NOT NULL
);

COMMENT ON COLUMN tos.tos_valid IS '0-폐기 1-신규 2-수정';

ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_no
);

ALTER TABLE auction ADD CONSTRAINT PK_AUCTION PRIMARY KEY (
	auction_no
);

ALTER TABLE attachment ADD CONSTRAINT PK_ATTACHMENT PRIMARY KEY (
	attachment_no
);

ALTER TABLE chatroom ADD CONSTRAINT PK_CHATROOM PRIMARY KEY (
	chatroom_no
);

ALTER TABLE photo ADD CONSTRAINT PK_PHOTO PRIMARY KEY (
	photo_no
);

ALTER TABLE category ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (
	category_no
);

ALTER TABLE member_rating ADD CONSTRAINT PK_MEMBER_RATING PRIMARY KEY (
	rating_no
);

ALTER TABLE rating ADD CONSTRAINT PK_RATING PRIMARY KEY (
	rating_item_no
);

ALTER TABLE chat_content ADD CONSTRAINT PK_CHAT_CONTENT PRIMARY KEY (
	chat_no
);

ALTER TABLE gps_address ADD CONSTRAINT PK_GPS_ADDRESS PRIMARY KEY (
	gps_no
);

ALTER TABLE chat_report ADD CONSTRAINT PK_CHAT_REPORT PRIMARY KEY (
	chat_report_no
);

ALTER TABLE manager_restriction ADD CONSTRAINT PK_MANAGER_RESTRICTION PRIMARY KEY (
	restriction_no
);

ALTER TABLE payment ADD CONSTRAINT PK_PAYMENT PRIMARY KEY (
	payment_no
);

ALTER TABLE auction_report ADD CONSTRAINT PK_AUCTION_REPORT PRIMARY KEY (
	auction_report_no
);

ALTER TABLE chatbot ADD CONSTRAINT PK_CHATBOT PRIMARY KEY (
	chatbot_no
);


ALTER TABLE tos ADD CONSTRAINT PK_TOS PRIMARY KEY (
	tos_no
);

ALTER TABLE member ADD CONSTRAINT FK_attachment_TO_member_1 FOREIGN KEY (
	attachment_no
)
REFERENCES attachment (
	attachment_no
);

ALTER TABLE auction ADD CONSTRAINT FK_member_TO_auction_1 FOREIGN KEY (
	auctioneer_no
)
REFERENCES member (
	member_no
);

ALTER TABLE auction ADD CONSTRAINT FK_category_TO_auction_1 FOREIGN KEY (
	category_no
)
REFERENCES category (
	category_no
);

ALTER TABLE chatroom ADD CONSTRAINT FK_member_TO_chatroom_1 FOREIGN KEY (
	participator_no
)
REFERENCES member (
	member_no
);

ALTER TABLE chatroom ADD CONSTRAINT FK_auction_TO_chatroom_1 FOREIGN KEY (
	auction_no
)
REFERENCES auction (
	auction_no
);

ALTER TABLE bidding ADD CONSTRAINT FK_member_TO_bidding_1 FOREIGN KEY (
	bidder_no
)
REFERENCES member (
	member_no
);

ALTER TABLE bidding ADD CONSTRAINT FK_auction_TO_bidding_1 FOREIGN KEY (
	auction_no
)
REFERENCES auction (
	auction_no
);

ALTER TABLE cashing_points ADD CONSTRAINT FK_member_TO_cashing_points_1 FOREIGN KEY (
	member_no
)
REFERENCES member (
	member_no
);

ALTER TABLE photo ADD CONSTRAINT FK_auction_TO_photo_1 FOREIGN KEY (
	photo_auction_no
)
REFERENCES auction (
	auction_no
);

ALTER TABLE photo ADD CONSTRAINT FK_attachment_TO_photo_1 FOREIGN KEY (
	photo_attachment_no
)
REFERENCES attachment (
	attachment_no
);

ALTER TABLE member_rating ADD CONSTRAINT FK_rating_TO_member_rating_1 FOREIGN KEY (
	rating_item_no
)
REFERENCES rating (
	rating_item_no
);

ALTER TABLE member_rating ADD CONSTRAINT FK_auction_TO_member_rating_1 FOREIGN KEY (
	auction_no
)
REFERENCES auction (
	auction_no
);

ALTER TABLE chat_content ADD CONSTRAINT FK_chatroom_TO_chat_content_1 FOREIGN KEY (
	chatroom_no
)
REFERENCES chatroom (
	chatroom_no
);

ALTER TABLE chat_content ADD CONSTRAINT FK_member_TO_chat_content_1 FOREIGN KEY (
	chatter_no
)
REFERENCES member (
	member_no
);


ALTER TABLE gps_address ADD CONSTRAINT FK_member_TO_gps_address_1 FOREIGN KEY (
	member_no
)
REFERENCES member (
	member_no
);

ALTER TABLE chat_report ADD CONSTRAINT FK FOREIGN KEY (
	chat_no
)
REFERENCES chat_content (
	chat_no
);

ALTER TABLE chat_report ADD CONSTRAINT FK_member_TO_chat_report_1 FOREIGN KEY (
	chat_reporter_no
)
REFERENCES member (
	member_no
);

ALTER TABLE manager_restriction ADD CONSTRAINT FK_manager_restriction FOREIGN KEY (
	member_no
)
REFERENCES member (
	member_no
);

ALTER TABLE payment ADD CONSTRAINT FK_member_TO_payment_1 FOREIGN KEY (
	member_no
)
REFERENCES member (
	member_no
);

ALTER TABLE auction_report ADD CONSTRAINT FK_auction_TO_auction_report_1 FOREIGN KEY (
	auction_no
)
REFERENCES auction (
	auction_no
);

ALTER TABLE auction_report ADD CONSTRAINT FK_member_TO_auction_report_1 FOREIGN KEY (
	auction_reporter_no
)
REFERENCES member (
	member_no
);

ALTER TABLE category_photo ADD CONSTRAINT FK1 FOREIGN KEY (
	category_no
)
REFERENCES category (
	category_no
);

ALTER TABLE category_photo ADD CONSTRAINT FK2 FOREIGN KEY (
	attachment_no
)
REFERENCES attachment (
	attachment_no
);

ALTER TABLE successful_bid ADD CONSTRAINT FK_auction_TO_successful_bid_1 FOREIGN KEY (
	auction_no
)
REFERENCES auction (
	auction_no
);


create table cert (
cert_target varchar2(100) primary key,
cert_no char(6) not null,
cert_time Date default sysdate not null 
);
