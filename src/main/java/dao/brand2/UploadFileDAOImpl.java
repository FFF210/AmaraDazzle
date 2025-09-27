package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.UploadFile;
import util.MybatisSqlSessionFactory;

public class UploadFileDAOImpl implements UploadFileDAO {
	
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public void insertUploadFile(UploadFile uploadfile) throws Exception {
		sqlSession.insert("mapper.uploadFile.insertUploadFile", uploadfile);
        sqlSession.commit();
	}
}
