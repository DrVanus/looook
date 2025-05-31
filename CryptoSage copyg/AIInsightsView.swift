import SwiftUI

struct AIInsightsView: View {
    @State private var lastUpdated: Date = Date()
    @State private var insightsSummary: String = "Loading AI summary..."

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                HStack {
                    Button(action: { /* handle back */ }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("AI Insights")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Text(lastUpdatedFormatted)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
                .padding(.horizontal, 16)
                .frame(height: 56)

                // Executive Summary Card
                ExecutiveSummaryCard(text: insightsSummary)

                // Snapshot Cards
                SnapshotCardsView()

                // Deep-Dive Sections
                VStack(spacing: 12) {
                    AnalyticsSection(title: "Performance & Attribution") {
                        BenchmarkChartView()
                        ContributorTableView()
                    }
                    AnalyticsSection(title: "Trade Quality & Timing") {
                        BestWorstTradeView()
                        HoldingPeriodHistogramView()
                    }
                    AnalyticsSection(title: "Diversification & Risk") {
                        InteractivePieChartView()
                        ConcentrationWarningView()
                    }
                    AnalyticsSection(title: "Momentum Analysis") {
                        MomentumBarChartView()
                        StrategyTextInsightView(text: "Analyzing your best strategy...")
                    }
                    AnalyticsSection(title: "Fee Breakdown") {
                        FeesBarChartView()
                        FeeTipTextView(text: "Tip: Schedule trades during off-peak hours to save on gas fees.")
                    }
                }
                .padding(.horizontal, 16)

                // Q&A Chat Widget
                QAChatWidget()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
            }
            .padding(.top, 16)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear(perform: fetchInsights)
    }

    private var lastUpdatedFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: lastUpdated)
    }

    private func fetchInsights() {
        // TODO: Call analytics API and LLM integration to populate insightsSummary and subviews
        // After fetching:
        // self.insightsSummary = fetchedSummary
        // self.lastUpdated = Date()
    }
}

// MARK: - Subviews

struct ExecutiveSummaryCard: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(16)
            .background(Color(white: 0.12))
            .cornerRadius(12)
    }
}

struct SnapshotCardsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                SnapshotCard(icon: "chart.line.uptrend.xyaxis", value: "8%", label: "vs BTC")
                SnapshotCard(icon: "shield.lefthalf.fill", value: "7/10", label: "Risk Score")
                SnapshotCard(icon: "rosette", value: "75%", label: "Win Rate")
                SnapshotCard(icon: "dollarsign.circle", value: "$120", label: "Fees")
            }
            .padding(.horizontal, 16)
        }
    }
}

struct SnapshotCard: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color.yellow)
            Text(value)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(Color(.lightGray))
        }
        .frame(width: 120, height: 120)
        .background(Color(white: 0.12))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
    }
}

// MARK: - AnalyticsSection

struct AnalyticsSection<Content: View>: View {
    let title: String
    let content: Content
    @State private var expanded: Bool = true

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            VStack(spacing: 12) {
                content
            }
            .padding(.top, 8)
        } label: {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(16)
        .background(Color(white: 0.12))
        .cornerRadius(12)
    }
}

// Stub subviews for illustration
struct BenchmarkChartView: View { var body: some View { Text("[Line Chart]").foregroundColor(.white) } }
struct ContributorTableView: View { var body: some View { Text("[Table of Contributors]").foregroundColor(.white) } }
struct BestWorstTradeView: View { var body: some View { Text("[Best & Worst Trade]").foregroundColor(.white) } }
struct HoldingPeriodHistogramView: View { var body: some View { Text("[Histogram]").foregroundColor(.white) } }
struct InteractivePieChartView: View { var body: some View { Text("[Interactive Pie Chart]").foregroundColor(.white) } }
struct ConcentrationWarningView: View { var body: some View { Text("[Concentration Warning if needed]").foregroundColor(.white) } }
struct MomentumBarChartView: View { var body: some View { Text("[Momentum Bar Chart]").foregroundColor(.white) } }
struct StrategyTextInsightView: View { let text: String; var body: some View { Text(text).italic().font(.system(size: 12)).foregroundColor(Color(.lightGray)) } }
struct FeesBarChartView: View { var body: some View { Text("[Fees Breakdown Chart]").foregroundColor(.white) } }
struct FeeTipTextView: View { let text: String; var body: some View { Text(text).font(.system(size: 12)).foregroundColor(Color(.lightGray)) } }
struct QAChatWidget: View { var body: some View { Text("[Chat Widget]").foregroundColor(.white).frame(height: 200).background(Color(white: 0.08)).cornerRadius(12) } }

// MARK: - Preview

struct AIInsightsView_Previews: PreviewProvider {
    static var previews: some View {
        AIInsightsView()
            .preferredColorScheme(.dark)
    }
}
