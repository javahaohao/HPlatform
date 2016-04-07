package ${table.pkg}.${table.bumodel}.service;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${table.pkg}.${table.bumodel}.entity.${table.domainName};
import com.hplatform.core.exception.CRUDException;
import ${table.pkg}.${table.bumodel}.mapper.${table.domainName}Mapper;
@Service
public class ${table.domainName}Service BaseService<${table.domainName}, ${table.domainName}Mapper>{
}