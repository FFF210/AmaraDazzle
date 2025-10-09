package dao;

import org.apache.ibatis.session.SqlSession;

import dto.UploadFile;
import util.MybatisSqlSessionFactory;

public class UploadFileDAOImpl implements UploadFileDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 파일 저장
	@Override
	public int insertFile(UploadFile f_dto) throws Exception {
		int result = ss.insert("mapper.uploadFile.insertUploadFile", f_dto);

		if (result > 0) {
			ss.commit();
		} else {
			ss.rollback();
		}

		return result;
	}

	// 저장된 파일의 id값 가져오기
	@Override
	public Long selectFileId(String fileRename) throws Exception {
		Long result = ss.selectOne("mapper.uploadFile.selectFileId", fileRename);

		return result;
	}

	// 파일 id 값으로 UploadFile 객체 가져오기
	@Override
	public UploadFile selectFileById(Long uploadFileId) throws Exception {
		return ss.selectOne("mapper.uploadFile.selectFileById", uploadFileId);
	}

	// ======= 파일 저장 후 생성된 ID 반환 =====
	@Override
	public Long insertFileAndGetId(UploadFile f_dto) throws Exception {
		// insertUploadFileWithAuto는 useGeneratedKeys="true"로 설정되어 있음
        int result = ss.insert("mapper.uploadFile.insertUploadFileWithAuto", f_dto);
        
        if (result > 0) {
            ss.commit();
            // MyBatis가 자동으로 f_dto의 uploadFileId를 채워줌
            return f_dto.getUploadFileId();
        } else {
            ss.rollback();
            throw new Exception("파일 저장 실패");
        }
	}

}
