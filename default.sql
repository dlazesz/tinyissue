PRAGMA synchronous = OFF;
PRAGMA journal_mode = MEMORY;
BEGIN TRANSACTION;
CREATE TABLE "activity" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "description" varchar(255) DEFAULT NULL,
  "activity" varchar(255) DEFAULT NULL
);
INSERT INTO "activity" VALUES (1,'Opened a new issue','create-issue');
INSERT INTO "activity" VALUES (2,'Commented on a issue','comment');
INSERT INTO "activity" VALUES (3,'Closed an issue','close-issue');
INSERT INTO "activity" VALUES (4,'Reopened an issue','reopen-issue');
INSERT INTO "activity" VALUES (5,'Reassigned an issue','reassign-issue');
CREATE TABLE "permissions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "permission" varchar(255) DEFAULT NULL,
  "description" text,
  "auto_has" varchar(255) DEFAULT NULL
);
INSERT INTO "permissions" VALUES (1,'issue-view','View issues in project assigned to',NULL);
INSERT INTO "permissions" VALUES (2,'issue-create','Create issues in projects assigned to',NULL);
INSERT INTO "permissions" VALUES (3,'issue-comment','Comment in issues in projects assigned to','1');
INSERT INTO "permissions" VALUES (4,'issue-modify','Modify issues in projects assigned to','1');
INSERT INTO "permissions" VALUES (11,'project-all','View, modify all projects and issues','1,2,3,4');
INSERT INTO "permissions" VALUES (6,'administration','Administration tools, such as user management and application settings.',NULL);
INSERT INTO "permissions" VALUES (9,'project-create','Create a new project',NULL);
INSERT INTO "permissions" VALUES (10,'project-modify','Modify a project assigned to',NULL);
CREATE TABLE "projects" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" varchar(255) DEFAULT NULL,
  "status" tinyint(2) DEFAULT '1',
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "projects_issues" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "created_by" bigint(20) DEFAULT NULL,
  "closed_by" bigint(20) DEFAULT NULL,
  "updated_by" bigint(20) DEFAULT NULL,
  "assigned_to" bigint(20) DEFAULT NULL,
  "project_id" bigint(20) DEFAULT NULL,
  "status" tinyint(2) DEFAULT '1',
  "title" varchar(255) DEFAULT NULL,
  "body" text,
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "closed_at" datetime DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "projects_issues_attachments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "issue_id" bigint(20) DEFAULT NULL,
  "comment_id" bigint(20) DEFAULT '0',
  "uploaded_by" bigint(20) DEFAULT NULL,
  "filesize" bigint(20) DEFAULT NULL,
  "filename" varchar(250) DEFAULT NULL,
  "fileextension" varchar(255) DEFAULT NULL,
  "upload_token" varchar(100) DEFAULT NULL,
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "projects_issues_comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "created_by" bigint(20) DEFAULT '0',
  "project_id" bigint(20) DEFAULT NULL,
  "issue_id" bigint(20) DEFAULT '0',
  "comment" text,
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "projects_users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "user_id" bigint(20) DEFAULT '0',
  "project_id" bigint(20) DEFAULT '0',
  "role_id" bigint(20) DEFAULT '0',
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "roles" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" varchar(255) DEFAULT NULL,
  "role" varchar(255) DEFAULT NULL,
  "description" varchar(255) DEFAULT NULL
);
INSERT INTO "roles" VALUES (1,'User','user','Only can read the issues in the projects they are assigned to');
INSERT INTO "roles" VALUES (2,'Developer','developer','Can update issues in the projects they are assigned to');
INSERT INTO "roles" VALUES (3,'Manager','manager','Can update issues in all projects, even if they aren''t assigned');
INSERT INTO "roles" VALUES (4,'Administrator','administrator','Can update all issues in all projects, create users and view administration');
CREATE TABLE "roles_permissions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "role_id" bigint(11) DEFAULT NULL,
  "permission_id" bigint(20) DEFAULT NULL
);
INSERT INTO "roles_permissions" VALUES (1,1,1);
INSERT INTO "roles_permissions" VALUES (2,1,2);
INSERT INTO "roles_permissions" VALUES (3,1,3);
INSERT INTO "roles_permissions" VALUES (4,2,1);
INSERT INTO "roles_permissions" VALUES (5,2,2);
INSERT INTO "roles_permissions" VALUES (6,2,3);
INSERT INTO "roles_permissions" VALUES (7,2,4);
INSERT INTO "roles_permissions" VALUES (8,3,11);
INSERT INTO "roles_permissions" VALUES (9,3,1);
INSERT INTO "roles_permissions" VALUES (10,3,2);
INSERT INTO "roles_permissions" VALUES (11,3,3);
INSERT INTO "roles_permissions" VALUES (12,3,4);
INSERT INTO "roles_permissions" VALUES (13,4,1);
INSERT INTO "roles_permissions" VALUES (14,4,2);
INSERT INTO "roles_permissions" VALUES (15,4,3);
INSERT INTO "roles_permissions" VALUES (16,4,6);
INSERT INTO "roles_permissions" VALUES (17,4,9);
INSERT INTO "roles_permissions" VALUES (18,4,10);
INSERT INTO "roles_permissions" VALUES (19,4,11);
INSERT INTO "roles_permissions" VALUES (20,4,4);
CREATE TABLE "sessions" (
  "id" varchar(40) NOT NULL,
  "last_activity" int(10) NOT NULL,
  "data" text NOT NULL
);
CREATE TABLE "settings" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "key" varchar(255) DEFAULT NULL,
  "value" text,
  "name" varchar(255) DEFAULT NULL
);
CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "role_id" bigint(20)  NOT NULL DEFAULT '1',
  "email" varchar(255) DEFAULT NULL,
  "password" varchar(255) DEFAULT NULL,
  "firstname" varchar(255) DEFAULT NULL,
  "lastname" varchar(255) DEFAULT NULL,
  "language" varchar(5) DEFAULT NULL,
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "deleted" int(1) NOT NULL DEFAULT '0'
);
INSERT INTO "users" VALUES (1,4,'admin@localhost','$2a$08$uGKZ8X8B3rvim7liF5o5meYRJtgwvfgOyZyVhpKrHdR/dTMv9/GQK','Admin','Administrator',NULL,'2014-04-23 15:30:36',NULL,0);
CREATE TABLE "users_activity" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "user_id" bigint(20) DEFAULT NULL,
  "parent_id" bigint(20) DEFAULT NULL,
  "item_id" bigint(20) DEFAULT NULL,
  "action_id" bigint(20) DEFAULT NULL,
  "type_id" int(11) DEFAULT NULL,
  "data" text,
  "created_at" datetime DEFAULT CURRENT_TIMESTAMP,
  "updated_at" datetime DEFAULT CURRENT_TIMESTAMP
);
END TRANSACTION;
