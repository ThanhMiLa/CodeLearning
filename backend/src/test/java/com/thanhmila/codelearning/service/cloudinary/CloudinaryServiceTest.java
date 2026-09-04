package com.thanhmila.codelearning.service.cloudinary;

import com.cloudinary.Cloudinary;
import com.cloudinary.Uploader;
import com.thanhmila.codelearning.dto.response.CloudinaryResponse;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;

import java.io.IOException;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("CloudinaryService Unit Tests")
class CloudinaryServiceTest {

    @Mock
    private Cloudinary cloudinary;

    @Mock
    private Uploader uploader;

    @InjectMocks
    private CloudinaryService cloudinaryService;

    @Test
    @DisplayName("uploadFile: Upload file thành công trả về publicId và secureUrl")
    void uploadFile_Success_ReturnsCloudinaryResponse() throws IOException {
        MockMultipartFile file = new MockMultipartFile("file", "test.png", "image/png", "sample-data".getBytes());

        when(cloudinary.uploader()).thenReturn(uploader);
        when(uploader.upload(any(byte[].class), any(Map.class)))
                .thenReturn(Map.of("public_id", "sample_pub_id", "secure_url", "https://res.cloudinary.com/demo/image/upload/sample.png"));

        CloudinaryResponse response = cloudinaryService.uploadFile(file, "courses");

        assertThat(response).isNotNull();
        assertThat(response.getPublicId()).isEqualTo("sample_pub_id");
        assertThat(response.getSecureUrl()).isEqualTo("https://res.cloudinary.com/demo/image/upload/sample.png");
    }

    @Test
    @DisplayName("deleteFile: Xóa file thành công gọi uploader.destroy")
    void deleteFile_Success_DestroysFile() throws IOException {
        when(cloudinary.uploader()).thenReturn(uploader);

        cloudinaryService.deleteFile("sample_pub_id");

        verify(uploader).destroy(eq("sample_pub_id"), any(Map.class));
    }

    @Test
    @DisplayName("deleteFile: Lỗi IOException ném RuntimeException")
    void deleteFile_IOException_ThrowsRuntimeException() throws IOException {
        when(cloudinary.uploader()).thenReturn(uploader);
        when(uploader.destroy(anyString(), any(Map.class))).thenThrow(new IOException("Network failure"));

        assertThatThrownBy(() -> cloudinaryService.deleteFile("sample_pub_id"))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Không thể xóa file cũ trên mây");
    }
}
