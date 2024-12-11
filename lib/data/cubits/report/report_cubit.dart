import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportRepository reportRepository;

  ReportCubit({required this.reportRepository}) : super(ReportInitial());

  Future<void> getReports() async {
    if (state is ReportLoading) return;
    emit(ReportLoading());
    loadReports();
  }

  Future<void> loadReports() async {
    final response = await reportRepository.getReports();

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportsLoaded(reports: response.data!));
    }
  }

  Future<void> loadAllPending() async {
    final response = await reportRepository.loadAllPending();

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportsLoaded(reports: response.data!));
    }
  }
  Future<void> loadAllInProgress() async {
    final response = await reportRepository.loadAllInProgress();

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportsLoaded(reports: response.data!));
    }
  }

  Future<void> loadAllFinished() async {
    final response = await reportRepository.loadAllFinished();

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportsLoaded(reports: response.data!));
    }
  }

  Future<void> createReport(ReportModel report) async {
    final response = await reportRepository.createReport(report);

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportSuccess(message: response.message));
    }
    loadReports();
  }

  Future<void> changeStatusIn(String reportId) async {
    final response = await reportRepository.changeStatusIn(reportId);

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportSuccess(message: response.message));
    }
    loadReports();
  }

  Future<void> changeStatusFinish(String reportId) async {
    final response = await reportRepository.changeStatusFinish(reportId);

    if (response.error) {
      emit(ReportError(message: response.message));
    } else {
      emit(ReportSuccess(message: response.message));
    }
    loadReports();
  }
}
