package com.hplatform.core.mapper;

import com.hplatform.core.entity.Comment;

public interface CommentMapper extends BaseMapper<Comment>{
	public void deleteEntityByParent(Comment comment);
}
