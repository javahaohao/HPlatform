package ${table.pkg}.${table.bumodel}.service;

import org.springframework.stereotype.Service;
import com.hplatform.core.service.BaseService;
import ${table.pkg}.${table.bumodel}.entity.${table.domainName};
import ${table.pkg}.${table.bumodel}.mapper.${table.domainName}Mapper;
@Service
public class ${table.domainName}Service extends BaseService<${table.domainName}, ${table.domainName}Mapper>{
}