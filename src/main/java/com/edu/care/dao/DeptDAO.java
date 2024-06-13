package com.edu.care.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edu.care.dto.DeptDTO;

@Mapper
public interface DeptDAO {

	List<DeptDTO> getDept();

}
