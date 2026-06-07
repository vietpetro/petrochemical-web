const fs = require('fs');
const path = 'C:/Users/DidierChan/Projects/petrochemical-web/data/products.json';
let data = JSON.parse(fs.readFileSync(path, 'utf8'));
const products = data.products;

function update(id, desc, specs) {
  const p = products.find(pr => pr.id === id);
  if (p) {
    p.description = desc;
    p.specs = specs;
  }
}

// Dầu DO 0,05S
update('do-005s', 'Dầu DO 0,05S là nhiên liệu diesel tiêu chuẩn với hàm lượng lưu huỳnh tối đa 0,05% (500 mg/kg), đáp ứng tiêu chuẩn TCVN 5685:2010 và ASTM D975. Phù hợp để sử dụng trong các thiết bị tiêu thụ năng lượng công nghiệp và vận tải đường bộ.', [
  { label: 'Hàm lượng lưu huỳnh', value: '≤ 0,05%' },
  { label: 'Số cetane', value: '≥ 48' },
  { label: 'Khối lượng riêng tại 15°C', value: '820 - 860 kg/m3' },
  { label: 'Nhiệt độ rung động lạnh', value: '≤ -10°C' }
]);

// Dầu DO 0,001S
update('do-0001s', 'Dầu DO 0,001S là nhiên liệu diesel siêu sạch (Ultra Low Sulfur Diesel - ULSD) với hàm lượng lưu huỳnh tối đa 0,001% (10 mg/kg), đạt tiêu chuẩn Euro 5 và TCVN 8694:2011. Thích hợp cho các động cơ hiện đại có hệ thống kiểm soát khí thải, giúp giảm ô nhiễm môi trường.', [
  { label: 'Hàm lượng lưu huỳnh', value: '≤ 0,001%' },
  { label: 'Số cetane', value: '≥ 46' },
  { label: 'Khối lượng riêng tại 15°C', value: '820 - 840 kg/m3' },
  { label: 'Nhiệt độ rung động lạnh', value: '≤ -15°C' }
]);

// Xăng E5 RON92
update('e5-ron92', 'Xăng E5 RON92 là hỗn hợp xăng chứa 5% ethanol, đạt chỉ số Oktan 92, tuân thủ tiêu chuẩn TCVN 7704:2008 và ASTM D4806. Phù hợp với hầu hết các xe ô tô hiện nay, giúp giảm phát thải CO2 và tối ưu hiệu suất đốt cháy.', [
  { label: 'Nồng độ ethanol', value: '5% v/v' },
  { label: 'Số Oktan (RON)', value: '92' },
  { label: 'Nhiệt độ sôi đầu', value: '≥ 35°C' },
  { label: 'Áp suất hơi', value: '≤ 15 psi' }
]);

// Xăng E10 RON95
update('e10-ron95', 'Xăng E10 RON95 là hỗn hợp xăng chứa 10% ethanol, đạt chỉ số Oktan 95, đáp ứng tiêu chuẩn TCVN 8693:2011 và ASTM D4806. Nguồn năng lượng tái tạo, giảm tiêu thụ nhiên liệu fosil và cải thiện môi trường.', [
  { label: 'Nồng độ ethanol', value: '10% v/v' },
  { label: 'Số Oktan (RON)', value: '95' },
  { label: 'Nhiệt độ sôi đầu', value: '≥ 30°C' },
  { label: 'Áp suất hơi', value: '≤ 12 psi' }
]);

fs.writeFileSync(path, JSON.stringify(data, null, 2));
console.log('Product descriptions updated successfully.');