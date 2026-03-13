package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.EMIResponseDTO;
import org.example.bankmanagement.dto.PageResponseDTO;
import org.example.bankmanagement.mapper.PageResponseMapper;
import org.example.bankmanagement.model.Account;
import org.example.bankmanagement.model.EMI;
import org.example.bankmanagement.model.Loan;
import org.example.bankmanagement.repo.AccountRepo;
import org.example.bankmanagement.repo.EMIRepo;
import org.example.bankmanagement.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service

public class EMIServiceImpl implements EMIService {

    private static final int PAGE_SIZE=10;
    private final EMIRepo eMIRepo;
    private final AccountRepo accountRepo;

    public EMIServiceImpl(EMIRepo eMIRepo, AccountRepo accountRepo) {
        this.eMIRepo = eMIRepo;
        this.accountRepo = accountRepo;
    }

    @Async
    @Override
    public void generateEmi(Loan loan) {

        double P = loan.getLoanAmount();
        double annualRate = loan.getLoanRate();
        int n = loan.getLoanTenure();

        double R = annualRate/12/100;
        double emiAmount =  (P * R * Math.pow(1+R,n)) / (Math.pow(1+R,n)-1);

        List<EMI> emiList = new ArrayList<>();

        for(int i=1;i<=n;i++){
            EMI emi = new EMI();
            emi.setEmiAmount(emiAmount);
            emi.setEmiDueDate(LocalDate.now().plusMonths(i));
            emi.setPaid(false);
            emi.setLoan(loan);
            emiList.add(emi);
        }
        loan.setEmi(emiList);
    }

    @Transactional
    @Override
    public String payEmi(long emiId) {
        EMI emi =eMIRepo.findById(emiId).orElseThrow(()->new ResourceNotFoundException("EMI not found"));

        Loan loan=emi.getLoan();
        Account account = loan.getCustomer().getAccounts().get(0);

        double emiAmount=emi.getEmiAmount();
        double accBalance=account.getAccBalance();

        if(accBalance - emiAmount < 2000){
            throw new IllegalArgumentException("Insufficient balance as account balance must be 2000");
        }

        account.setAccBalance(account.getAccBalance()-emi.getEmiAmount());

        emi.setPaid(true);
        emi.setPaidDare(LocalDate.now());

        accountRepo.save(account);
        eMIRepo.save(emi);

        return "EMI paid success";
    }

    @Override
    public PageResponseDTO<EMIResponseDTO> getAllEmiByLoanId(long loanId,int page) {

        int page_index = page  - 1;
        Pageable pageable = PageRequest.of(page_index,PAGE_SIZE, Sort.by("emiDueDate").ascending());
        Page<EMI> emiPage = eMIRepo.findByLoanLoanId(loanId,pageable);

        return PageResponseMapper.mapPage(emiPage,e->{
            EMIResponseDTO response = new EMIResponseDTO();
            response.setEmiId(e.getEmiId());
            response.setEmiAmount(e.getEmiAmount());
            response.setEmiDueDate(e.getEmiDueDate());
            response.setPaid(e.isPaid());
            response.setEmiPaidDate(e.getPaidDare());

            return response;
        });
    }

    @Override
    public PageResponseDTO<EMIResponseDTO> getAllEmiByCustId(long custId,int page){
        int pageIndex =page - 1;
        Pageable pageable = PageRequest.of(pageIndex,PAGE_SIZE,Sort.by("emiDueDate").ascending());
        Page<EMI> emiPage = eMIRepo.findByLoanCustomerCustId(custId,pageable);

        return PageResponseMapper.mapPage(emiPage,e->{
            EMIResponseDTO response =new EMIResponseDTO();
            response.setEmiId(e.getEmiId());
            response.setEmiAmount(e.getEmiAmount());
            response.setEmiDueDate(e.getEmiDueDate());
            response.setPaid(e.isPaid());
            response.setEmiPaidDate(e.getPaidDare());

            return response;
        });
    }

}
