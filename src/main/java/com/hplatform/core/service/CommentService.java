package com.hplatform.core.service;

import java.util.List;

import com.hplatform.core.entity.Comment;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.mapper.CommentMapper;

public class CommentService extends BaseService<Comment, CommentMapper>{

    public void deleteComment(String resourceId) throws CRUDException {
    	Comment comment = new Comment();
    	comment.setId(resourceId);
    	Comment result = super.findOne(comment);
    	super.delete(comment);
        m.deleteEntityByParent(result);
    }

    public Comment findOne(String resourceId) throws CRUDException {
    	Comment comment = new Comment();
    	comment.setId(resourceId);
        return super.findOne(comment);
    }

    public List<Comment> findAll() throws CRUDException {
        return super.findAll(new Comment());
    }
}
