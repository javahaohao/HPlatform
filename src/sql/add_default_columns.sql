ALTER TABLE `tb_class_info`  ADD COLUMN `create_user` CHAR(32) comment '创建人';
ALTER TABLE `tb_class_info`  ADD COLUMN `update_user` CHAR(32) comment '修改人';
ALTER TABLE `tb_class_info`  ADD COLUMN `create_date` DATETIME comment '创建时间';
ALTER TABLE `tb_class_info`  ADD COLUMN `update_date` DATETIME comment '修改时间';