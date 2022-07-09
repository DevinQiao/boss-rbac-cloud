package com.boss.common.selector;

import com.boss.common.config.BossAuthExceptionConfigure;
import com.boss.common.config.BossOAuth2FeignConfigure;
import com.boss.common.config.BossServerProtectConfigure;
import org.springframework.context.annotation.ImportSelector;
import org.springframework.core.type.AnnotationMetadata;

/**
 * @author DevinJoe
 * @since 2022/7/9
 */
public class BossCloudApplicationSelector implements ImportSelector {

    @Override
    public String[] selectImports(AnnotationMetadata annotationMetadata) {
        return new String[]{
                BossAuthExceptionConfigure.class.getName(),
                BossServerProtectConfigure.class.getName(),
                BossOAuth2FeignConfigure.class.getName()
        };
    }
}
