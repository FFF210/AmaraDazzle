package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.UploadFile;
import util.MybatisSqlSessionFactory;

public class UploadFileDAOImpl implements UploadFileDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
    public void insertUploadFileWithAuto(UploadFile uploadFile) {
			sqlSession.insert("mapper.uploadFile.insertUploadFileWithAuto", uploadFile);
    }

    @Override
    public UploadFile selectUploadFileById(Long uploadFileId) {
    	try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.uploadFile.selectUploadFileById", uploadFileId);
        }
    }
}
