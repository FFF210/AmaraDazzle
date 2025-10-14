package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.UploadFile;
import util.MybatisSqlSessionFactory;

public class UploadFileDAOImpl implements UploadFileDAO {
	@Override
	public void insertUploadFileWithAuto(UploadFile uploadFile) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.uploadFile.insertUploadFileWithAuto", uploadFile);
			sqlSession.commit();
		}
	}

	@Override
	public UploadFile selectUploadFileById(Long uploadFileId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.uploadFile.selectUploadFileById", uploadFileId);
		}
	}

	// 파일 id 값으로 UploadFile 객체 가져오기
	@Override
	public UploadFile selectFileById(Long uploadFileId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.uploadFile.selectFileById", uploadFileId);
		}
	}
}
