package org.example.bankmanagement.DTO;

import lombok.Data;

import java.util.List;

@Data
public class PageResponseDTO<T> {

   private List<T> content;
   private  int page;
   private int size;
   private long totalElements;
   private int totalPages;
   public boolean last;

}
