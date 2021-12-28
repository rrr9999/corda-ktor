create USER "party_a" WITH LOGIN PASSWORD 'test';
create SCHEMA "party_a_schema";

-- allow the user to access the schema and create objects in that schema.
grant USAGE, create ON SCHEMA "party_a_schema" TO "party_a";

-- adding permissions for current tables in that schema and the tables created in the future.
grant select, insert, update, delete, REFERENCES ON ALL tables IN SCHEMA "party_a_schema" TO "party_a";
alter DEFAULT privileges IN SCHEMA "party_a_schema" grant select, insert, update, delete, REFERENCES ON tables TO "party_a";
grant USAGE, select ON ALL sequences IN SCHEMA "party_a_schema" TO "party_a";
alter DEFAULT privileges IN SCHEMA "party_a_schema" grant USAGE, select ON sequences TO "party_a";
alter role "party_a" SET search_path = "party_a_schema";

-- doing the same for observer
create USER "observer" with LOGIN PASSWORD 'test';
create SCHEMA "observer_schema";
grant USAGE, create ON SCHEMA "observer_schema" TO "observer";
grant select, insert, update, delete, REFERENCES ON ALL tables IN SCHEMA "observer_schema" TO "observer";
alter DEFAULT privileges IN SCHEMA "observer_schema" grant select, insert, update, delete, REFERENCES ON tables TO "observer";
grant USAGE, select ON ALL sequences IN SCHEMA "observer_schema" TO "observer";
alter DEFAULT privileges IN SCHEMA "observer_schema" grant USAGE, select ON sequences TO "observer";
alter role "observer" SET search_path = "observer_schema";

CREATE TABLE "party_a_schema".databasechangelog
(
    id            varchar(255) NOT NULL,
    author        varchar(255) NOT NULL,
    filename      varchar(255) NOT NULL,
    dateexecuted  timestamp    NOT NULL,
    orderexecuted int4         NOT NULL,
    exectype      varchar(10)  NOT NULL,
    md5sum        varchar(35)  NULL,
    description   varchar(255) NULL,
    comments      varchar(255) NULL,
    tag           varchar(255) NULL,
    liquibase     varchar(20)  NULL,
    contexts      varchar(255) NULL,
    labels        varchar(255) NULL,
    deployment_id varchar(10)  NULL
);

CREATE TABLE "party_a_schema".databasechangeloglock
(
    id          int4         NOT NULL,
    locked      bool         NOT NULL,
    lockgranted timestamp    NULL,
    lockedby    varchar(255) NULL,
    CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id)
);

GRANT INSERT, UPDATE, DELETE ON TABLE "party_a_schema".databasechangelog TO party_a;

CREATE TABLE "observer_schema".databasechangelog
(
    id            varchar(255) NOT NULL,
    author        varchar(255) NOT NULL,
    filename      varchar(255) NOT NULL,
    dateexecuted  timestamp    NOT NULL,
    orderexecuted int4         NOT NULL,
    exectype      varchar(10)  NOT NULL,
    md5sum        varchar(35)  NULL,
    description   varchar(255) NULL,
    comments      varchar(255) NULL,
    tag           varchar(255) NULL,
    liquibase     varchar(20)  NULL,
    contexts      varchar(255) NULL,
    labels        varchar(255) NULL,
    deployment_id varchar(10)  NULL
);

CREATE TABLE "observer_schema".databasechangeloglock
(
    id          int4         NOT NULL,
    locked      bool         NOT NULL,
    lockgranted timestamp    NULL,
    lockedby    varchar(255) NULL,
    CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id)
);

GRANT INSERT, UPDATE, DELETE ON TABLE "observer_schema".databasechangelog TO observer;
