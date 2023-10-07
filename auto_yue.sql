/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : auto_yue

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 07/10/2023 13:11:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app01_department
-- ----------------------------
DROP TABLE IF EXISTS `app01_department`;
CREATE TABLE `app01_department`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app01_department
-- ----------------------------
INSERT INTO `app01_department` VALUES (1, '教学部');
INSERT INTO `app01_department` VALUES (2, '销售部');

-- ----------------------------
-- Table structure for app01_host
-- ----------------------------
DROP TABLE IF EXISTS `app01_host`;
CREATE TABLE `app01_host`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hostname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` char(39) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depart_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app01_host_depart_id_ba5981e9_fk_app01_department_id`(`depart_id`) USING BTREE,
  CONSTRAINT `app01_host_depart_id_ba5981e9_fk_app01_department_id` FOREIGN KEY (`depart_id`) REFERENCES `app01_department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app01_host
-- ----------------------------
INSERT INTO `app01_host` VALUES (1, 'www.baidu.com', '202.108.22.5', 1);
INSERT INTO `app01_host` VALUES (2, 'www.163.com', '59.111.254.0', 1);
INSERT INTO `app01_host` VALUES (3, 'www.tencent.com', '60.221.153.218', 1);
INSERT INTO `app01_host` VALUES (5, '本机', '223.88.55.196', 2);

-- ----------------------------
-- Table structure for app01_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `app01_userinfo`;
CREATE TABLE `app01_userinfo`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level` int NOT NULL,
  `depart_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `app01_userinfo_depart_id_e22e0907_fk_app01_department_id`(`depart_id`) USING BTREE,
  CONSTRAINT `app01_userinfo_depart_id_e22e0907_fk_app01_department_id` FOREIGN KEY (`depart_id`) REFERENCES `app01_department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app01_userinfo
-- ----------------------------
INSERT INTO `app01_userinfo` VALUES (1, '彭于晏', '123', 'pengyuyan@gmail.com', '15033351234', 1, 1);
INSERT INTO `app01_userinfo` VALUES (2, '吴彦祖', '123', 'wuyanzu@gmail.com', '13899991072', 2, 1);
INSERT INTO `app01_userinfo` VALUES (3, '胡歌', '123', 'huge@gmail.com', '17633335828', 3, 1);
INSERT INTO `app01_userinfo` VALUES (5, 'jiejie', '123', 'jiejie@gmail.com', '17622226568', 1, 1);

-- ----------------------------
-- Table structure for app01_userinfo_roles
-- ----------------------------
DROP TABLE IF EXISTS `app01_userinfo_roles`;
CREATE TABLE `app01_userinfo_roles`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app01_userinfo_roles_userinfo_id_role_id_c1a899a5_uniq`(`userinfo_id`, `role_id`) USING BTREE,
  INDEX `app01_userinfo_roles_role_id_7144c267_fk_rbac_role_id`(`role_id`) USING BTREE,
  CONSTRAINT `app01_userinfo_roles_role_id_7144c267_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `app01_userinfo_roles_userinfo_id_fcfbbfcf_fk_app01_userinfo_id` FOREIGN KEY (`userinfo_id`) REFERENCES `app01_userinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app01_userinfo_roles
-- ----------------------------
INSERT INTO `app01_userinfo_roles` VALUES (1, 1, 1);
INSERT INTO `app01_userinfo_roles` VALUES (2, 2, 2);
INSERT INTO `app01_userinfo_roles` VALUES (3, 3, 3);
INSERT INTO `app01_userinfo_roles` VALUES (4, 5, 1);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add department', 1, 'add_department');
INSERT INTO `auth_permission` VALUES (2, 'Can change department', 1, 'change_department');
INSERT INTO `auth_permission` VALUES (3, 'Can delete department', 1, 'delete_department');
INSERT INTO `auth_permission` VALUES (4, 'Can view department', 1, 'view_department');
INSERT INTO `auth_permission` VALUES (5, 'Can add user info', 2, 'add_userinfo');
INSERT INTO `auth_permission` VALUES (6, 'Can change user info', 2, 'change_userinfo');
INSERT INTO `auth_permission` VALUES (7, 'Can delete user info', 2, 'delete_userinfo');
INSERT INTO `auth_permission` VALUES (8, 'Can view user info', 2, 'view_userinfo');
INSERT INTO `auth_permission` VALUES (9, 'Can add host', 3, 'add_host');
INSERT INTO `auth_permission` VALUES (10, 'Can change host', 3, 'change_host');
INSERT INTO `auth_permission` VALUES (11, 'Can delete host', 3, 'delete_host');
INSERT INTO `auth_permission` VALUES (12, 'Can view host', 3, 'view_host');
INSERT INTO `auth_permission` VALUES (13, 'Can add menu', 4, 'add_menu');
INSERT INTO `auth_permission` VALUES (14, 'Can change menu', 4, 'change_menu');
INSERT INTO `auth_permission` VALUES (15, 'Can delete menu', 4, 'delete_menu');
INSERT INTO `auth_permission` VALUES (16, 'Can view menu', 4, 'view_menu');
INSERT INTO `auth_permission` VALUES (17, 'Can add permission', 5, 'add_permission');
INSERT INTO `auth_permission` VALUES (18, 'Can change permission', 5, 'change_permission');
INSERT INTO `auth_permission` VALUES (19, 'Can delete permission', 5, 'delete_permission');
INSERT INTO `auth_permission` VALUES (20, 'Can view permission', 5, 'view_permission');
INSERT INTO `auth_permission` VALUES (21, 'Can add role', 6, 'add_role');
INSERT INTO `auth_permission` VALUES (22, 'Can change role', 6, 'change_role');
INSERT INTO `auth_permission` VALUES (23, 'Can delete role', 6, 'delete_role');
INSERT INTO `auth_permission` VALUES (24, 'Can view role', 6, 'view_role');
INSERT INTO `auth_permission` VALUES (25, 'Can add log entry', 7, 'add_logentry');
INSERT INTO `auth_permission` VALUES (26, 'Can change log entry', 7, 'change_logentry');
INSERT INTO `auth_permission` VALUES (27, 'Can delete log entry', 7, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (28, 'Can view log entry', 7, 'view_logentry');
INSERT INTO `auth_permission` VALUES (29, 'Can add permission', 8, 'add_permission');
INSERT INTO `auth_permission` VALUES (30, 'Can change permission', 8, 'change_permission');
INSERT INTO `auth_permission` VALUES (31, 'Can delete permission', 8, 'delete_permission');
INSERT INTO `auth_permission` VALUES (32, 'Can view permission', 8, 'view_permission');
INSERT INTO `auth_permission` VALUES (33, 'Can add group', 9, 'add_group');
INSERT INTO `auth_permission` VALUES (34, 'Can change group', 9, 'change_group');
INSERT INTO `auth_permission` VALUES (35, 'Can delete group', 9, 'delete_group');
INSERT INTO `auth_permission` VALUES (36, 'Can view group', 9, 'view_group');
INSERT INTO `auth_permission` VALUES (37, 'Can add user', 10, 'add_user');
INSERT INTO `auth_permission` VALUES (38, 'Can change user', 10, 'change_user');
INSERT INTO `auth_permission` VALUES (39, 'Can delete user', 10, 'delete_user');
INSERT INTO `auth_permission` VALUES (40, 'Can view user', 10, 'view_user');
INSERT INTO `auth_permission` VALUES (41, 'Can add content type', 11, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (42, 'Can change content type', 11, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (43, 'Can delete content type', 11, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (44, 'Can view content type', 11, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (45, 'Can add session', 12, 'add_session');
INSERT INTO `auth_permission` VALUES (46, 'Can change session', 12, 'change_session');
INSERT INTO `auth_permission` VALUES (47, 'Can delete session', 12, 'delete_session');
INSERT INTO `auth_permission` VALUES (48, 'Can view session', 12, 'view_session');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (7, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (1, 'app01', 'department');
INSERT INTO `django_content_type` VALUES (3, 'app01', 'host');
INSERT INTO `django_content_type` VALUES (2, 'app01', 'userinfo');
INSERT INTO `django_content_type` VALUES (9, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (8, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (10, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (11, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (4, 'rbac', 'menu');
INSERT INTO `django_content_type` VALUES (5, 'rbac', 'permission');
INSERT INTO `django_content_type` VALUES (6, 'rbac', 'role');
INSERT INTO `django_content_type` VALUES (12, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2023-10-06 12:49:42.498284');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2023-10-06 12:49:43.021180');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2023-10-06 12:49:43.149784');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2023-10-06 12:49:43.160752');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2023-10-06 12:49:43.169809');
INSERT INTO `django_migrations` VALUES (6, 'rbac', '0001_initial', '2023-10-06 12:49:43.503258');
INSERT INTO `django_migrations` VALUES (7, 'app01', '0001_initial', '2023-10-06 12:49:43.775680');
INSERT INTO `django_migrations` VALUES (8, 'contenttypes', '0002_remove_content_type_name', '2023-10-06 12:49:43.859494');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0002_alter_permission_name_max_length', '2023-10-06 12:49:43.908326');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0003_alter_user_email_max_length', '2023-10-06 12:49:43.960187');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0004_alter_user_username_opts', '2023-10-06 12:49:43.968165');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0005_alter_user_last_login_null', '2023-10-06 12:49:44.013045');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0006_require_contenttypes_0002', '2023-10-06 12:49:44.017629');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0007_alter_validators_add_error_messages', '2023-10-06 12:49:44.027093');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0008_alter_user_username_max_length', '2023-10-06 12:49:44.083924');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0009_alter_user_last_name_max_length', '2023-10-06 12:49:44.142275');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0010_alter_group_name_max_length', '2023-10-06 12:49:44.198022');
INSERT INTO `django_migrations` VALUES (18, 'auth', '0011_update_proxy_permissions', '2023-10-06 12:49:44.211209');
INSERT INTO `django_migrations` VALUES (19, 'auth', '0012_alter_user_first_name_max_length', '2023-10-06 12:49:44.267009');
INSERT INTO `django_migrations` VALUES (20, 'sessions', '0001_initial', '2023-10-06 12:49:44.304255');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('539kt2acj1qheflx86zqgl43n2mg7pvk', '.eJy9mNuOmzAQQP-Fp1ZNFDBgIKraX-h7UyGCTYOWhIiLVqtV_r1jdoExZdhkQ3hBAeGZM-MTjHk1XmoZnmVxTMsyzU9hXWRhlpZV-CRfjO2rUZeyaC6ok1QYW2dlVGmVSWNr7GrPZf6u5sz2drXLLDj6PveNlQFh4IaNGr1Rozdw7ayGn-osg5_he4z2tLlfnVxWbykjIdqMLs7IRbJXuSITZx9khMFdQgdlmyJ-Z9CYWxgp0q5-rtWfWBwiJIE1QaNGb778_PX9_PRjtxPfvs7KJmTWonkYzWUMWhRw7kygweDHkRWylFV4fu4m0sd8gRUL1UAuIeQ-hjZ6vmkN-JoQm3NUls95IR6CeshBdix4gCkdaYNu3LOjccHV6JsFb1IiwS2TMrxPP0iJDQ_0BpDIXQMQdEuDDbcsSnESh1Z8DjikuMUox0k20vE70Yp9FG-LPJOaPZaNAf1AMDgyj43ro2JsVIybHeqzY5EcSqQeZCw5tkkVgNtCltC1ZViERqeJ5VJiTePRds0Mi0XjlGjTrKRt86Ee5anWndMe_L4tYghpu-6EcyrG55xrsmPnfPrhZapFWkYehhoD0fzzBn2iytH7hArSSDX_AvrBdi3qhIvzgiMXmUk_9K7lpr2cDbuUcX4S4VAQZtGC-PGH9G9Re09UEU2KVCxSCRaIMVqgG0tZwiNcBtbJpnW6sYoFrEJ7EywVudJxz7FVPa454O4DdR7hBj1QJ1SCZhO5HF5TwxICIXDsD7k0XsO9gDLHOqtStKktO3JtoeTMC5p9SAK_HbUbcRI3nqiiiYtqKZdg1zrvU_xXzcL__AtMhoCzIt3XlRydEW1J7slVFpOr6hwxqKIPODoVH77HANjgm0fz_3__3sHUYXw36e0jtc13TA65UnhywB1JtD7kRwkX4kOaiULCxd_3fSi5_AFCW8fAexMKIyrEOk_WBxkV6envGNFnd7YNkaUT4amiiAQAjXHct0e6rOZ4622jzCggtOly-Qewif5l:1qoyFr:ytaAaG6PDwob6f2oOCs56Y1r9Rllj3kDm5r4lfV0ZCc', '2023-10-21 03:45:27.486010');

-- ----------------------------
-- Table structure for rbac_menu
-- ----------------------------
DROP TABLE IF EXISTS `rbac_menu`;
CREATE TABLE `rbac_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rbac_menu
-- ----------------------------
INSERT INTO `rbac_menu` VALUES (1, '权限管理', 'fa-hdd-o');
INSERT INTO `rbac_menu` VALUES (2, '用户管理', 'fa-home');
INSERT INTO `rbac_menu` VALUES (3, '主机管理', 'fa-hard-of-hearing');

-- ----------------------------
-- Table structure for rbac_permission
-- ----------------------------
DROP TABLE IF EXISTS `rbac_permission`;
CREATE TABLE `rbac_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_id` bigint NULL DEFAULT NULL,
  `pid_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rbac_permission_menu_id_3dcc68be_fk_rbac_menu_id`(`menu_id`) USING BTREE,
  INDEX `rbac_permission_pid_id_6939354d_fk_rbac_permission_id`(`pid_id`) USING BTREE,
  CONSTRAINT `rbac_permission_menu_id_3dcc68be_fk_rbac_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `rbac_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rbac_permission_pid_id_6939354d_fk_rbac_permission_id` FOREIGN KEY (`pid_id`) REFERENCES `rbac_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rbac_permission
-- ----------------------------
INSERT INTO `rbac_permission` VALUES (4, '用户列表', '/user/list/', 'user_list', 2, NULL);
INSERT INTO `rbac_permission` VALUES (5, '添加用户', '/user/add/', 'user_add', NULL, 4);
INSERT INTO `rbac_permission` VALUES (6, '编辑用户', '/user/edit/(?P<pk>\\d+)/', 'user_edit', NULL, 4);
INSERT INTO `rbac_permission` VALUES (7, '删除用户', '/user/del/(?P<pk>\\d+)/', 'user_del', NULL, 4);
INSERT INTO `rbac_permission` VALUES (8, '重置密码', '/user/reset/password/(?P<pk>\\d+)/', 'user_reset_pwd', NULL, 4);
INSERT INTO `rbac_permission` VALUES (9, '主机列表', '/host/list/', 'host_list', 3, NULL);
INSERT INTO `rbac_permission` VALUES (10, '添加主机', '/host/add/', 'host_add', NULL, 9);
INSERT INTO `rbac_permission` VALUES (11, '编辑主机', '/host/edit/(?P<pk>\\d+)/', 'host_edit', NULL, 9);
INSERT INTO `rbac_permission` VALUES (12, '删除主机', '/host/del/(?P<pk>\\d+)/', 'host_del', NULL, 9);
INSERT INTO `rbac_permission` VALUES (13, '角色列表', '/rbac/role/list/', 'rbac:role_list', 1, NULL);
INSERT INTO `rbac_permission` VALUES (14, '添加角色', '/rbac/role/add/', 'rbac:role_add', NULL, 13);
INSERT INTO `rbac_permission` VALUES (15, '编辑角色', '/rbac/role/edit/(?P<pk>\\d+)/', 'rbac:role_edit', NULL, 13);
INSERT INTO `rbac_permission` VALUES (16, '删除角色', '/rbac/role/del/(?P<pk>\\d+)/', 'rbac:role_del', NULL, 13);
INSERT INTO `rbac_permission` VALUES (17, '菜单列表', '/rbac/menu/list/', 'rbac:menu_list', 1, NULL);
INSERT INTO `rbac_permission` VALUES (18, '添加一级菜单', '/rbac/menu/add/', 'rbac:menu_add', NULL, 17);
INSERT INTO `rbac_permission` VALUES (19, '编辑一级菜单', '/rbac/menu/edit/(?P<pk>\\d+)/', 'rbac:menu_edit', NULL, 17);
INSERT INTO `rbac_permission` VALUES (20, '删除一级菜单', '/rbac/menu/del/(?P<pk>\\d+)/', 'rbac:menu_del', NULL, 17);
INSERT INTO `rbac_permission` VALUES (21, '添加二级菜单', '/rbac/second/menu/add/(?P<menu_id>\\d+)/', 'rbac:second_menu_add', NULL, 17);
INSERT INTO `rbac_permission` VALUES (22, '编辑二级菜单', '/rbac/second/menu/edit/(?P<pk>\\d+)/', 'rbac:second_menu_edit', NULL, 17);
INSERT INTO `rbac_permission` VALUES (23, '删除二级菜单', '/rbac/second/menu/del/(?P<pk>\\d+)/', 'rbac:second_menu_del', NULL, 17);
INSERT INTO `rbac_permission` VALUES (24, '添加权限', '/rbac/permission/add/(?P<second_menu_id>\\d+)/', 'rbac:permission_add', NULL, 17);
INSERT INTO `rbac_permission` VALUES (25, '编辑权限', '/rbac/permission/edit/(?P<pk>\\d+)/', 'rbac:permission_edit', NULL, 17);
INSERT INTO `rbac_permission` VALUES (26, '删除权限', '/rbac/permission/del/(?P<pk>\\d+)/', 'rbac:permission_del', NULL, 17);
INSERT INTO `rbac_permission` VALUES (27, '批量操作权限', '/rbac/multi/permissions/', 'rbac:multi_permissions', NULL, 17);
INSERT INTO `rbac_permission` VALUES (28, '批量删除权限', '/rbac/multi/permissions/del/(?P<pk>\\d+)/', 'rbac:multi_permissions_del', NULL, 17);
INSERT INTO `rbac_permission` VALUES (29, '权限分配', '/rbac/distribute/permissions/', 'rbac:distribute_permissions', 1, NULL);

-- ----------------------------
-- Table structure for rbac_role
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role`;
CREATE TABLE `rbac_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rbac_role
-- ----------------------------
INSERT INTO `rbac_role` VALUES (1, 'CEO');
INSERT INTO `rbac_role` VALUES (2, 'CTO');
INSERT INTO `rbac_role` VALUES (3, 'CFO');
INSERT INTO `rbac_role` VALUES (4, 'UFO');

-- ----------------------------
-- Table structure for rbac_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role_permissions`;
CREATE TABLE `rbac_role_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `rbac_role_permissions_role_id_permission_id_d01303da_uniq`(`role_id`, `permission_id`) USING BTREE,
  INDEX `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` FOREIGN KEY (`permission_id`) REFERENCES `rbac_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rbac_role_permissions_role_id_d10416cb_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rbac_role_permissions
-- ----------------------------
INSERT INTO `rbac_role_permissions` VALUES (1, 1, 4);
INSERT INTO `rbac_role_permissions` VALUES (2, 1, 5);
INSERT INTO `rbac_role_permissions` VALUES (3, 1, 6);
INSERT INTO `rbac_role_permissions` VALUES (4, 1, 7);
INSERT INTO `rbac_role_permissions` VALUES (5, 1, 8);
INSERT INTO `rbac_role_permissions` VALUES (6, 1, 9);
INSERT INTO `rbac_role_permissions` VALUES (7, 1, 10);
INSERT INTO `rbac_role_permissions` VALUES (8, 1, 11);
INSERT INTO `rbac_role_permissions` VALUES (9, 1, 12);
INSERT INTO `rbac_role_permissions` VALUES (10, 1, 13);
INSERT INTO `rbac_role_permissions` VALUES (11, 1, 14);
INSERT INTO `rbac_role_permissions` VALUES (12, 1, 15);
INSERT INTO `rbac_role_permissions` VALUES (13, 1, 16);
INSERT INTO `rbac_role_permissions` VALUES (14, 1, 17);
INSERT INTO `rbac_role_permissions` VALUES (15, 1, 18);
INSERT INTO `rbac_role_permissions` VALUES (16, 1, 19);
INSERT INTO `rbac_role_permissions` VALUES (17, 1, 20);
INSERT INTO `rbac_role_permissions` VALUES (18, 1, 21);
INSERT INTO `rbac_role_permissions` VALUES (19, 1, 22);
INSERT INTO `rbac_role_permissions` VALUES (20, 1, 23);
INSERT INTO `rbac_role_permissions` VALUES (21, 1, 24);
INSERT INTO `rbac_role_permissions` VALUES (22, 1, 25);
INSERT INTO `rbac_role_permissions` VALUES (23, 1, 26);
INSERT INTO `rbac_role_permissions` VALUES (24, 1, 27);
INSERT INTO `rbac_role_permissions` VALUES (25, 1, 28);
INSERT INTO `rbac_role_permissions` VALUES (26, 1, 29);
INSERT INTO `rbac_role_permissions` VALUES (27, 2, 4);
INSERT INTO `rbac_role_permissions` VALUES (28, 2, 5);
INSERT INTO `rbac_role_permissions` VALUES (29, 2, 6);
INSERT INTO `rbac_role_permissions` VALUES (30, 2, 8);
INSERT INTO `rbac_role_permissions` VALUES (31, 2, 9);
INSERT INTO `rbac_role_permissions` VALUES (32, 2, 10);
INSERT INTO `rbac_role_permissions` VALUES (33, 2, 11);
INSERT INTO `rbac_role_permissions` VALUES (34, 2, 13);
INSERT INTO `rbac_role_permissions` VALUES (35, 2, 14);
INSERT INTO `rbac_role_permissions` VALUES (36, 2, 15);
INSERT INTO `rbac_role_permissions` VALUES (37, 2, 17);
INSERT INTO `rbac_role_permissions` VALUES (38, 2, 18);
INSERT INTO `rbac_role_permissions` VALUES (39, 2, 19);
INSERT INTO `rbac_role_permissions` VALUES (40, 2, 20);
INSERT INTO `rbac_role_permissions` VALUES (41, 2, 21);
INSERT INTO `rbac_role_permissions` VALUES (42, 2, 22);
INSERT INTO `rbac_role_permissions` VALUES (43, 2, 24);
INSERT INTO `rbac_role_permissions` VALUES (44, 2, 25);
INSERT INTO `rbac_role_permissions` VALUES (45, 2, 27);
INSERT INTO `rbac_role_permissions` VALUES (46, 2, 29);
INSERT INTO `rbac_role_permissions` VALUES (47, 3, 4);
INSERT INTO `rbac_role_permissions` VALUES (48, 3, 5);
INSERT INTO `rbac_role_permissions` VALUES (49, 3, 6);
INSERT INTO `rbac_role_permissions` VALUES (50, 3, 9);
INSERT INTO `rbac_role_permissions` VALUES (51, 3, 10);
INSERT INTO `rbac_role_permissions` VALUES (52, 3, 11);
INSERT INTO `rbac_role_permissions` VALUES (53, 3, 13);
INSERT INTO `rbac_role_permissions` VALUES (54, 3, 14);
INSERT INTO `rbac_role_permissions` VALUES (55, 3, 15);
INSERT INTO `rbac_role_permissions` VALUES (56, 3, 17);
INSERT INTO `rbac_role_permissions` VALUES (57, 3, 18);
INSERT INTO `rbac_role_permissions` VALUES (58, 3, 19);
INSERT INTO `rbac_role_permissions` VALUES (59, 3, 21);
INSERT INTO `rbac_role_permissions` VALUES (60, 3, 22);
INSERT INTO `rbac_role_permissions` VALUES (61, 3, 29);
INSERT INTO `rbac_role_permissions` VALUES (62, 4, 5);
INSERT INTO `rbac_role_permissions` VALUES (63, 4, 6);
INSERT INTO `rbac_role_permissions` VALUES (64, 4, 11);
INSERT INTO `rbac_role_permissions` VALUES (65, 4, 14);
INSERT INTO `rbac_role_permissions` VALUES (66, 4, 15);

SET FOREIGN_KEY_CHECKS = 1;
