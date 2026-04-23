# W3: Xương Sống Database  
**Thời gian:** 20–24/04/2026  

---

# Mục Tiêu Tuần 3
Triển khai tầng Database + AI + Lambda + Networking trên AWS, và chứng minh hoạt động bằng **Evidence Pack**.

---

# 1. Điều Kiện Kế Thừa Từ W2 (Bắt Buộc)

- S3 bucket từ W2 vẫn:
  - Block Public Access = ON
  - Encryption = Enabled
  - Versioning = Enabled
- IAM:
  - Root bật MFA
  - Có Admin Group
  - Dùng IAM Users, không dùng root
  - Fix toàn bộ feedback W2
- VPC Diagram W2 được mở rộng, không tạo mới
- Có cite 1 feedback từ W2 và cách W3 cải thiện


# 2. Core Must-Haves (4 Deliverables)

## A. Database Layer

## Chọn 1 database phù hợp dữ liệu app:

- Relational → RDS / Aurora / PostgreSQL / MySQL
- Key-Value → DynamoDB
- Document → DocumentDB / MongoDB
- Graph → Neptune

## Yêu cầu chung:

- Deploy private subnet
- Không public access
- Encryption at rest
- Có HA plan:
  - Multi-AZ / replica / snapshot plan / SPOF reasoning
- Có write + read dữ liệu thật

## Theo loại DB:

### DocumentDB / MongoDB

- 1 Aggregation pipeline
- 1 indexed lookup


## B. AI / Bedrock Layer

- Tạo Bedrock Knowledge Base
- Kết nối bucket S3 từ W2
- Ingest ít nhất 3 documents
- Sync status = Complete
- Ghi rõ:
  - Embedding model
  - Vector store
- Có 1 API call thật:
  - Retrieve hoặc RetrieveAndGenerate

## C. Lambda Layer

- Tạo ít nhất 1 Lambda function
- Kết nối:
  - Database hoặc Bedrock
- Có trigger thật:
  - S3 Event hoặc API Gateway
- Có output thật:
  - CloudWatch Logs / ghi DB / Bedrock response

## IAM Rule:

- Không Action: "*"
- Không Resource: "*"


## D. VPC + Networking

- Diagram có 3 tầng:
  - Public Tier
  - Private App Tier
  - Private DB Tier
- Có S3 Gateway Endpoint
- Có route table entry
- DB Security Group chỉ allow App SG
- Giải thích được khi nào dùng NACL thay vì SG


# 3. Data Access Pattern Log (Section bắt buộc)

## Part A – 3 Access Patterns thật

Ví dụ:

- Lấy đơn hàng user theo ngày (~50 lần/phút)
- Tìm xe theo hãng (~30 lần/phút)
- Gợi ý xe phù hợp (~20 lần/phút)

## Part B – Với mỗi pattern ghi:

- Engine dùng
- Paradigm
- Index / PK / GSI / Aggregation / Traversal
- Vì sao tối ưu

## Part C – Wrong Paradigm Test

Giải thích nếu dùng sai loại DB thì lỗi gì / cost cao ra sao.


# 4. Evidence Pack (Quan Trọng Nhất)

## File bắt buộc:

`docs/W3_evidence.md`

## Nội dung:

### Cover

- Group number
- Member names
- Chosen DB path
- Link W2 evidence

### Section Database

- Screenshot config
- Screenshot query chạy thật
- Giải thích ngắn

### Section Bedrock

- KB setup
- Documents synced
- Retrieve result

### Section Lambda

- Trigger
- Logs
- Output

### Section Networking

- Route table
- Endpoint
- Security Groups

### Section Security Test

- 1 truy cập trái phép bị deny

---

# 5. Live Demo Thứ Sáu (10–12 phút)

## Part 1 – W2 Recap

- Review W2
- Feedback đã sửa

## Part 2 – W3 Architecture

- Diagram mới
- Data Access Pattern Log

## Part 3 – Q&A

- Trả lời decision architecture

## Part 4 – Demo

- DB write/read
- 2 query đúng paradigm
- Bedrock retrieval
- Lambda trigger
- Unauthorized access denied


# 6. Điểm Quan Trọng

- Không Evidence Pack → cap thấp
- Chỉ ảnh không giải thích → cap thấp
- Có screenshots + notes + query thật → điểm cao


# 7. Output Cuối Tuần Cần Có

- Working AWS database layer
- Working Bedrock KB
- Working Lambda trigger
- Secure VPC 3-tier
- docs/W3_evidence.md đầy đủ
- Slides trình bày từ markdown
