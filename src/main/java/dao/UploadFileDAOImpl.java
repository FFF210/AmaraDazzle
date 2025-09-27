package dao;

import org.apache.ibatis.session.SqlSession;

import dto.UploadFile;
import util.MybatisSqlSessionFactory;

public class UploadFileDAOImpl implements UploadFileDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	//파일 저장 
	@Override
	public int insertFile(UploadFile f_dto) throws Exception {
		int result = ss.insert("mapper.uploadFile.insertUploadFile", f_dto);
		
		if(result > 0) {
			ss.commit();
		} else {
			ss.rollback();
		}
		
		
		return result;		
	}

	//저장된 파일의 id값 가져오기 
	@Override
	public Long selectFileId(String fileRename) throws Exception {
		Long result = ss.selectOne("mapper.uploadFile.selectFileId", fileRename);
		
		return result;		
	}

	


	

}
