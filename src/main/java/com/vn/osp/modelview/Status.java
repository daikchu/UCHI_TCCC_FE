package com.vn.osp.modelview;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Status {
    private String code;
    private String name;
    private String description;
    private String type;
}
