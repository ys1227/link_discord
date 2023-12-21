module ApplicationHelper
  def default_meta_tags
    {
      title: '🚀Link_Disco🚀',
      reverse: true,
      charset: 'utf-8',
      description: '💫Disordで集まる人を募集するサービスです💫',
      keywords: 'Discord',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),# 配置するパスやファイル名によって変更する
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードに変更
        site: '@Saki_y2000', # アプリの公式Twitterアカウントがあれば、アカウント名を記載
        image: image_url('ogp.png'),# 配置するパスやファイル名によって変更
      }
    }
  end
end
