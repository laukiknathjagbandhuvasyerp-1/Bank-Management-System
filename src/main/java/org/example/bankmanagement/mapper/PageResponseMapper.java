package org.example.bankmanagement.mapper;

import org.example.bankmanagement.dto.PageResponseDTO;
import org.springframework.data.domain.Page;
import java.util.List;
import java.util.function.Function;

public class PageResponseMapper {
    public static <T,R>PageResponseDTO<R> mapPage(Page<T> page, Function<T,R> mapper){
        List<R> content = page.getContent().stream().map(mapper).toList();

        PageResponseDTO<R> response = new PageResponseDTO<>();
        response.setContent(content);
        response.setPage(page.getNumber()+1);
        response.setTotalPages(page.getTotalPages());
        response.setSize(page.getSize());
        response.setTotalElements(page.getTotalElements());
        response.setLast(page.isLast());

        return response;
    }
}
