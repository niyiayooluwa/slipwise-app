import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class VerifyOtpFormState {
  final TextEditingController otpController;
  final ValueNotifier<bool> isFormValid;
  final GlobalKey<ShadFormState> formKey;

  VerifyOtpFormState({
    required this.otpController,
    required this.isFormValid,
    required this.formKey,
  });
}

VerifyOtpFormState useVerifyOtpForm() {
  final otpController = useTextEditingController();
  final isFormValid = useState(false);
  final formKey = useMemoized(() => GlobalKey<ShadFormState>());

  useEffect(() {
    void updateFormValidity() {
      // Assuming a standard 6-digit OTP code
      isFormValid.value = otpController.text.trim().length == 6;
    }

    otpController.addListener(updateFormValidity);

    return () {
      otpController.removeListener(updateFormValidity);
    };
  }, [otpController]);

  return VerifyOtpFormState(
    otpController: otpController,
    isFormValid: isFormValid,
    formKey: formKey,
  );
}
