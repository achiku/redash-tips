create table dummy_time (
  tm timestamp with time zone not null
);


create table coolec_user (
  id bigserial
  , gender integer not null
  , birthday date not null
  , registered_at timestamp with time zone not null

  , primary key (id)
);

create table sdk_install_event (
  id bigserial
  , network_name text not null
  , installed_at timestamp with time zone not null

  , primary key (id)
);

create table sdk_registration_event (
  id bigserial
  , user_id bigint not null
  , network_name text not null
  , registered_at timestamp with time zone not null

  , primary key (id)
  , foreign key(user_id) references coolec_user (id)
);
