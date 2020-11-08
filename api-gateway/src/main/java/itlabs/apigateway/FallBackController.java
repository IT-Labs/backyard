package itlabs.apigateway;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/fallback")
@CrossOrigin
public class FallBackController {
// TODO: enable cors
    @GetMapping("/message")
    public ResponseEntity<FallbackModel> message() {

        final ResponseEntity<FallbackModel> modelResponseEntity =  ResponseEntity.ok()
                .header("fallback","fallback")
                .body(FallbackModel.builder().message("Service can to be contacted").build());

        return modelResponseEntity;
    }

}
