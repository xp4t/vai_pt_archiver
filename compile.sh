echo " "
echo "----------------------------------------------------------------------------------"
echo " COMPILE VCoR QUANTIZED CNN"
echo "----------------------------------------------------------------------------------"
echo " "
source ./scripts/run_compile.sh zcu104  ResNet_0_int.xmodel
source ./scripts/run_compile.sh zcu102  ResNet_0_int.xmodel
source ./scripts/run_compile.sh vck190  ResNet_0_int.xmodel
source ./scripts/run_compile.sh vek280  ResNet_0_int.xmodel
source ./scripts/run_compile.sh vck5000 ResNet_0_int.xmodel
source ./scripts/run_compile.sh v70     ResNet_0_int.xmodel
mv   ./build/compiled_zcu104/zcu104_ResNet_0_int.xmodel.xmodel  ./target/vcor/zcu104_train_resnet18_vcor.xmodel
mv   ./build/compiled_zcu102/zcu102_ResNet_0_int.xmodel.xmodel  ./target/vcor/zcu102_train_resnet18_vcor.xmodel
mv   ./build/compiled_vck190/vck190_ResNet_0_int.xmodel.xmodel  ./target/vcor/vck190_train_resnet18_vcor.xmodel
mv   ./build/compiled_vek280/vek280_ResNet_0_int.xmodel.xmodel  ./target/vcor/vek280_train_resnet18_vcor.xmodel
mv ./build/compiled_vck5000/vck5000_ResNet_0_int.xmodel.xmodel  ./target/vcor/vck5000_train_resnet18_vcor.xmodel
mv ./build/compiled_v70/v70_ResNet_0_int.xmodel.xmodel          ./target/vcor/v70_train_resnet18_vcor.xmodel

# ===========================================================================
# prepare archive for TARGET ZCU102 runtime application for VCoR
# ===========================================================================
echo " "
echo "----------------------------------------------------------------------------------"
echo " PREPARING VCoR ARCHIVE FOR TARGET BOARDS"
echo "----------------------------------------------------------------------------------"
echo " "
cp -r target       ./build
cd ./build/data/vcor
tar -cvf test_jpg.tar ./test > /dev/null
cp test_jpg.tar       ../../../build/target/vcor/
rm test_jpg.tar
cd ../../../
#prepare test images from jpg to png
cd ./build/target/vcor/
tar -xvf test_jpg.tar
cd ../../../
python ./code/generate_target_test_images.py
cd ./build/target/vcor/
tar -cvf test.tar ./test > /dev/null
rm -f  ./test_jpg.tar
rm -rf ./test
cd ../../../
#rm -rf ./build/target/imagenet #unuseful at the moment
# zcu104
cp -r ./build/target/  ./build/target_zcu104  > /dev/null
rm -f ./build/target_zcu104/vcor/vck*_vcor.xmodel
rm -f ./build/target_zcu104/vcor/vek*_vcor.xmodel
rm -f ./build/target_zcu104/vcor/v70*_vcor.xmodel
# zcu102
cp -r ./build/target/  ./build/target_zcu102  > /dev/null
rm -f ./build/target_zcu102/vcor/vck*_vcor.xmodel
rm -f ./build/target_zcu102/vcor/vek*_vcor.xmodel
rm -f ./build/target_zcu102/vcor/v70*_vcor.xmodel
# vck190
cp -r ./build/target/  ./build/target_vck190  > /dev/null
rm -f ./build/target_vck190/vcor/zcu1*_vcor.xmodel
rm -f ./build/target_vck190/vcor/vek2*_vcor.xmodel
rm -f ./build/target_vck190/vcor/vck5*_vcor.xmodel
rm -f ./build/target_vck190/vcor/v70*_vcor.xmodel
# vek280
cp -r ./build/target   ./build/target_vek280  > /dev/null
rm -f ./build/target_vek280/vcor/zcu*_vcor.xmodel
rm -f ./build/target_vek280/vcor/vck*_vcor.xmodel
rm -f ./build/target_vek280/vcor/v70*_vcor.xmodel
# vck5000
cp -r ./build/target/  ./build/target_vck5000  > /dev/null
rm -f ./build/target_vck5000/vcor/zcu1*_vcor.xmodel
rm -f ./build/target_vck5000/vcor/vek2*_vcor.xmodel
rm -f ./build/target_vck5000/vcor/vck1*_vcor.xmodel
rm -f ./build/target_vck5000/vcor/v70*_vcor.xmodel
# v70
cp -r ./build/target/  ./build/target_v70  > /dev/null
rm -f ./build/target_v70/vcor/zcu1*_vcor.xmodel
rm -f ./build/target_v70/vcor/vek2*_vcor.xmodel
rm -f ./build/target_v70/vcor/vck*_vcor.xmodel
# built tar files
cd ./build
tar -cvf ./target_vek280.tar  ./target_vek280
tar -cvf ./target_vck190.tar  ./target_vck190
tar -cvf ./target_zcu102.tar  ./target_zcu102
tar -cvf ./target_zcu104.tar  ./target_zcu104
tar -cvf ./target_v70.tar     ./target_v70
tar -cvf ./target_vck5000.tar ./target_vck5000
cd ..
